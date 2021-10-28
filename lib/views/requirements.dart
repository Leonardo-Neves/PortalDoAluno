import 'package:flutter/material.dart';

// App
import 'package:projeto/base_widget.dart';
import 'package:projeto/controller/requirements.controller.dart';
import 'package:projeto/modules/CustomColor.dart';

// View
import 'package:projeto/views/newrequirements.dart';
import 'package:projeto/views/requirementsdetails.dart';

// View Model
import 'package:projeto/view-models/attendment.viewmodel.dart';
import 'package:projeto/view-models/requirements.viewmodel.dart';

// Packages
import 'package:provider/provider.dart';

class Requirements extends StatefulWidget {
  Requirements({Key? key}) : super(key: key);

  @override
  _RequirementsState createState() => _RequirementsState();
}

class _RequirementsState extends State<Requirements>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;
  List<AttendmentViewModel> attendmentsViewModel = [];
  List<RequirementViewModel> requirementsViewModel = [];
  var user;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    Future.delayed(Duration.zero, () async {
      RequirementsController requirementsController =
          new RequirementsController(api: Provider.of(context, listen: false));

      var attendments = await requirementsController.getAttendments();

      var student = requirementsController.getStudent();

      var requirements =
          await requirementsController.getRequirements('${student.id}');

      setState(() {
        attendmentsViewModel = attendments;
        user = student;
        requirementsViewModel = requirements;
      });
    });
  }

  @override
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RequirementsController>(
      model: RequirementsController(api: Provider.of(context)),
      builder: (context, model, child) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(CustomColor.WhiteLight),
            toolbarHeight: 70.0,
            elevation: 0.0,
            leading: IconButton(
              iconSize: 22.0,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_rounded),
              color: Color(CustomColor.BlueNormal),
            ),
            leadingWidth: 80.0,
            title: Text(
              'Requerimentos',
              style: TextStyle(
                color: Color(CustomColor.BlueNormal),
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size(0, 40.0),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: Color(CustomColor.White),
                  borderRadius: BorderRadius.circular(22.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Color(CustomColor.White),
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                  unselectedLabelColor:
                      Color(CustomColor.GrayDark).withOpacity(0.5),
                  indicator: BoxDecoration(
                    color: Color(CustomColor.OrangeNormal),
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  tabs: [
                    Tab(
                      text: 'Disponíveis',
                    ),
                    Tab(
                      text: 'Solicitados',
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            controller: _tabController,
            children: [
              Available(
                attendmentsViewModel: attendmentsViewModel,
              ),
              Solicited(
                requirementsViewModel: requirementsViewModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Available extends StatefulWidget {
  final List<AttendmentViewModel> attendmentsViewModel;
  const Available({Key? key, required this.attendmentsViewModel})
      : super(key: key);

  @override
  State<Available> createState() => _AvailableState();
}

class _AvailableState extends State<Available> {
  int selectedIndex = 0;
  var attendments = [];
  var categories = [
    'Todos',
    'Ouvidoria',
    'Protocolos',
    'Serviços acadêmicos',
    'Serviços financeiros',
  ];

  @override
  void initState() {
    super.initState();

    attendments = widget.attendmentsViewModel;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Atendimentos',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(CustomColor.BlueNormal),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 40.0,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 12.0,
                    );
                  },
                  itemCount: categories.length,
                  shrinkWrap: true,
                  primary: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InputChip(
                      padding: const EdgeInsets.all(10.0),
                      backgroundColor: selectedIndex == index
                          ? Color(CustomColor.OrangeNormal)
                          : Color(CustomColor.White),
                      selectedColor: selectedIndex == index ? Colors.red : null,
                      label: Text(
                        categories[index],
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: selectedIndex == index
                              ? Color(CustomColor.White)
                              : Color(CustomColor.GrayDark),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });

                        attendments = [];

                        for (var i = 0;
                            i < widget.attendmentsViewModel.length;
                            i++) {
                          if (categories[selectedIndex] == 'Todos') {
                            attendments.add(widget.attendmentsViewModel[i]);
                          } else {
                            if (categories[selectedIndex] ==
                                (widget.attendmentsViewModel[i].type)) {
                              attendments.add(widget.attendmentsViewModel[i]);
                            }
                          }
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 12.0,
                  );
                },
                itemCount: attendments.length,
                shrinkWrap: true,
                primary: true,
                reverse: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CardAvailable(
                    attendmentViewModel: attendments[index],
                  );
                },
              ),
              widget.attendmentsViewModel.length == 0
                  ? Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.2,
                          ),
                          CircularProgressIndicator(
                            color: Color(CustomColor.OrangeNormal),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Carregando...',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Color(CustomColor.GrayDark),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(''),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardAvailable extends StatelessWidget {
  final AttendmentViewModel attendmentViewModel;
  const CardAvailable({Key? key, required this.attendmentViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () async {
        await Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => NewRequirements(
              attendmentViewModel: attendmentViewModel,
            ),
          ),
        );
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color(CustomColor.White),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width * 0.65,
                  child: Text(
                    attendmentViewModel.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(CustomColor.OrangeNormal),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${attendmentViewModel.type} - ${attendmentViewModel.price != 0 ? 'R\$${attendmentViewModel.price}' : 'Gratuito'}',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Color(CustomColor.BlueNormal),
                  ),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20.0,
              color: Color(CustomColor.BlueNormal),
            ),
          ],
        ),
      ),
    );
  }
}

class Solicited extends StatefulWidget {
  final List<RequirementViewModel> requirementsViewModel;
  const Solicited({Key? key, required this.requirementsViewModel})
      : super(key: key);

  @override
  State<Solicited> createState() => _SolicitedState();
}

class _SolicitedState extends State<Solicited> {
  var emailTextInputController;

  @override
  void initState() {
    super.initState();
    emailTextInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 10.0,
              ),
              height: 42.0,
              decoration: BoxDecoration(
                color: Color(CustomColor.White),
                borderRadius: BorderRadius.circular(22.0),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(CustomColor.GrayDark),
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 24.0,
                    color: Color(CustomColor.GrayDark),
                  ),
                  border: InputBorder.none,
                  hintText: 'N° Protocolo',
                  hintStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(CustomColor.GrayDark),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 22.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(CustomColor.GrayLighter),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                ),
              ),
            ),
            ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 12.0,
                );
              },
              itemCount: widget.requirementsViewModel.length,
              shrinkWrap: true,
              primary: true,
              reverse: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return CardSolicited(
                  requirementViewModel: widget.requirementsViewModel[index],
                );
              },
            ),
            widget.requirementsViewModel.length == 0
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.2,
                        ),
                        CircularProgressIndicator(
                          color: Color(CustomColor.OrangeNormal),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Carregando...',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Color(CustomColor.GrayDark),
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}

class CardSolicited extends StatelessWidget {
  final RequirementViewModel requirementViewModel;
  const CardSolicited({Key? key, required this.requirementViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => RequirementsDetails(
              requirementViewModel: requirementViewModel,
            ),
          ),
        );
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color(CustomColor.White),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              requirementViewModel.attendment.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(CustomColor.OrangeNormal),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'N° ${requirementViewModel.protocolNumber}',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Color(CustomColor.BlueNormal),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              '23/09/2021 10:06:35',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Color(CustomColor.GrayDark),
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              'Etapa: ${requirementViewModel.step}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Color(CustomColor.GrayDark),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              requirementViewModel.status,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Color(CustomColor.OrangeNormal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
