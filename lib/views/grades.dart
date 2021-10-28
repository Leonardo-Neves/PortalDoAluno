import 'package:flutter/material.dart';
import 'package:projeto/modules/CustomColor.dart';
import 'package:projeto/view-models/lake.viewmodel.dart';

// View Model
import 'package:projeto/view-models/subject.viewmodel.dart';

// App
import 'package:projeto/controller/grades.controller.dart';
import 'package:projeto/modules/components.dart';
import 'package:projeto/base_widget.dart';

// Packages
import 'package:provider/provider.dart';

class Grades extends StatefulWidget {
  const Grades({Key? key}) : super(key: key);

  @override
  _GradesState createState() => _GradesState();
}

class _GradesState extends State<Grades> {
  var _itemsDropDownSubject = [''];
  var _itemsDropDownPeriod = [''];

  String? valueDropDownSubject;
  String? valueDropDownPeriod;

  List<SubjectViewModel> subjects = [];

  SubjectViewModel selectedSubject = new SubjectViewModel();

  dynamic user;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      GradesController gradesController =
          new GradesController(api: Provider.of(context, listen: false));
      var userData = await gradesController.getStudent();

      setState(() => user = userData);

      var period = await gradesController.getPeriod(user.ra);

      setState(() => _itemsDropDownPeriod = period);
    });
  }

  void dispose() {
    super.dispose();
  }

  DropdownMenuItem<String> buildMenuItemDropdown(String item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Color(CustomColor.GrayDark),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget subTitle(String label, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Color(CustomColor.BlueNormal),
          ),
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Color(CustomColor.BlueNormal),
          ),
        ),
      ],
    );
  }

  Widget item(String label, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Color(CustomColor.GrayDark),
          ),
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Color(CustomColor.GrayDark),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseWidget<GradesController>(
      model: GradesController(api: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        appBar: Header(
          title: 'Notas',
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: Color(CustomColor.WhiteLight),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              decoration: BoxDecoration(
                                color: Color(CustomColor.WhiteLighter),
                                borderRadius: BorderRadius.circular(22.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text(
                                    'Período',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(CustomColor.GrayDark),
                                    ),
                                  ),
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  iconSize: 20.0,
                                  value: this.valueDropDownPeriod,
                                  items: _itemsDropDownPeriod
                                      .map(
                                          (item) => buildMenuItemDropdown(item))
                                      .toList(),
                                  onChanged: (value) async {
                                    setState(
                                        () => this.valueDropDownPeriod = value);

                                    var subjectViewModel =
                                        await model.getGrades(user.ra, value);

                                    subjectViewModel.forEach((subject) {
                                      if (_itemsDropDownSubject
                                              .contains(subject.name) ==
                                          false) {
                                        setState(() => _itemsDropDownSubject
                                            .add(subject.name));
                                        setState(() => subjects.add(subject));
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: size.width,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            decoration: BoxDecoration(
                              color: Color(CustomColor.WhiteLighter),
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(
                                  'Disciplina',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(CustomColor.GrayDark),
                                  ),
                                ),
                                value: valueDropDownSubject,
                                iconSize: 20.0,
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: _itemsDropDownSubject
                                    .map(buildMenuItemDropdown)
                                    .toList(),
                                onChanged: (value) => {
                                  setState(
                                      () => this.valueDropDownSubject = value),
                                  subjects.forEach((subject) {
                                    if (subject.name == value)
                                      setState(() => selectedSubject = subject);
                                  })
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Matéria',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(CustomColor.BlueNormal),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  width: size.width * 0.83,
                                  child: Text(
                                    selectedSubject.name.isNotEmpty
                                        ? selectedSubject.name
                                        : 'Nenhuma matéria selecionada',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color(CustomColor.OrangeNormal),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        subTitle('Avaliações', 'Notas'),
                        SizedBox(
                          height: 16.0,
                        ),
                        item('Avaliação Presencial',
                            '${selectedSubject.grade.presencialEvaluation != 0 ? selectedSubject.grade.presencialEvaluation : '--'}'),
                        SizedBox(
                          height: 12.0,
                        ),
                        item('Avaliação de Desempenho',
                            '${selectedSubject.grade.performanceEvaluation != 0 ? selectedSubject.grade.performanceEvaluation : '--'}'),
                        SizedBox(
                          height: 12.0,
                        ),
                        item('Exame Final',
                            '${selectedSubject.grade.finalExam != 0 ? selectedSubject.grade.finalExam : '--'}'),
                        SizedBox(
                          height: 12.0,
                        ),
                        item('Média Semestral',
                            '${selectedSubject.grade.semesterMean != 0 ? selectedSubject.grade.semesterMean : '--'}'),
                        SizedBox(
                          height: 12.0,
                        ),
                        item('Média Final',
                            '${selectedSubject.grade.finalMean != 0 ? selectedSubject.grade.finalMean : '--'}'),
                        SizedBox(
                          height: 16.0,
                        ),
                        subTitle('Informações adicionais', ''),
                        SizedBox(
                          height: 16.0,
                        ),
                        item('Filial',
                            '${selectedSubject.branch != '' ? selectedSubject.branch : '--'}'),
                        SizedBox(
                          height: 12.0,
                        ),
                        item('Turma',
                            '${selectedSubject.classes != '' ? selectedSubject.classes : '--'}'),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Situação',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Color(CustomColor.BlueNormal),
                              ),
                            ),
                            Text(
                              '${selectedSubject.status != '' ? selectedSubject.status : '--'}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Color(CustomColor.OrangeNormal),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        (() {
                          if (selectedSubject.lake.length > 0) {
                            return Column(
                              children: [
                                subTitle('Faltas', ''),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  height: 102.0,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    reverse: true,
                                    shrinkWrap: true,
                                    primary: true,
                                    itemCount: selectedSubject.lake.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return LakeItem(
                                        lakeViewModel:
                                            selectedSubject.lake[index],
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Percentual de faltas',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Color(CustomColor.BlueNormal),
                                      ),
                                    ),
                                    Text(
                                      '95%',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Color(CustomColor.OrangeNormal),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LakeItem extends StatelessWidget {
  final LakeViewModel lakeViewModel;

  const LakeItem({Key? key, required this.lakeViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 111.0,
      height: 102.0,
      padding: const EdgeInsets.all(14.0),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Color(CustomColor.White),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lakeViewModel.chooseMounth(lakeViewModel),
            style: TextStyle(
              color: Color(CustomColor.OrangeNormal),
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lakeViewModel.name,
                style: TextStyle(
                  color: Color(CustomColor.BlueNormal),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${lakeViewModel.lake} faltas',
                style: TextStyle(
                  color: Color(CustomColor.OrangeNormal),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
