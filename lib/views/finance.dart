import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto/modules/CustomColor.dart';

// App
import 'package:projeto/modules/components.dart';
import 'package:projeto/controller/finance.controller.dart';
import 'package:projeto/base_widget.dart';

// View Model
import 'package:projeto/view-models/finance.viewmodel.dart';

// Packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Finance extends StatefulWidget {
  const Finance({Key? key}) : super(key: key);

  @override
  _FinanceState createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  var _itemsDropDown = [''];

  String? initialValueDropdownPeriod;
  String selectedValueDropdownPeriod = '';
  dynamic user;
  List<FinanceViewModel> financeViewModel = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      FinanceController financeController =
          new FinanceController(api: Provider.of(context, listen: false));
      var userData = await financeController.getStudent();

      setState(() => user = userData);

      var period = await financeController.getPeriod(user.ra);

      setState(() => _itemsDropDown = period);
    });
  }

  DropdownMenuItem<String> buildMenuItemDropdown(String item) {
    return DropdownMenuItem(
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseWidget<FinanceController>(
      model: FinanceController(api: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        appBar: Header(
          title: 'Financeiro',
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: Color(CustomColor.WhiteLight),
            ),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Mensalidades',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Color(CustomColor.BlueNormal),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
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
                              value: this.initialValueDropdownPeriod,
                              items: _itemsDropDown
                                  .map((item) => buildMenuItemDropdown(item))
                                  .toList(),
                              onChanged: (value) async {
                                setState(() =>
                                    this.initialValueDropdownPeriod = value);
                                var financesViewModel =
                                    await model.getFinance('$value');
                                setState(() {
                                  financeViewModel = financesViewModel;
                                  selectedValueDropdownPeriod = '$value';
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 12.0,
                        );
                      },
                      shrinkWrap: true,
                      primary: true,
                      itemCount: financeViewModel.length,
                      itemBuilder: (context, index) {
                        return Card(
                          financeViewModel: financeViewModel[index],
                          periodFinance: selectedValueDropdownPeriod,
                        );
                      },
                    ),
                    (() {
                      if (financeViewModel.length == 0) {
                        return Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            SvgPicture.asset(
                              'asset/image/imageFinance.svg',
                              width: size.width * 0.6,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: size.width * 0.5,
                              child: Text(
                                'Selecione um período para pesquisar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(CustomColor.GrayDark),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Text('');
                      }
                    }()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final FinanceViewModel financeViewModel;
  final String periodFinance;
  const Card({
    Key? key,
    required this.financeViewModel,
    required this.periodFinance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return Wrap(children: [
              Modal(
                financeViewModel: financeViewModel,
              )
            ]);
          },
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(CustomColor.White),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${financeViewModel.financeDateToMonth(financeViewModel.dueDate)}/${'${DateFormat('dd/MM/yyyy').format(DateTime.parse(financeViewModel.dueDate))}'.split('/')[2]}',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Color(CustomColor.OrangeNormal),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200.0),
                      color: Color(CustomColor.OrangeNormal),
                    ),
                    child: Text(
                      financeViewModel.status,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Color(CustomColor.White),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.event_note,
                          color: Color(CustomColor.GrayDark),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          '${DateFormat('dd/MM/yyyy').format(DateTime.parse(financeViewModel.dueDate))}',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(CustomColor.GrayDark),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timeline,
                          color: Color(CustomColor.GrayDark),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          periodFinance,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(CustomColor.GrayDark),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'R\$ ${financeViewModel.grossValue}',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Color(CustomColor.BlueNormal),
                      ),
                    ),
                    Text(
                      'R\$ ${financeViewModel.scholarshipInconditional}',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Color(CustomColor.BlueNormal),
                          decoration: TextDecoration.lineThrough),
                    ),
                    Text(
                      'Valor a pagar',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Color(CustomColor.OrangeNormal),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Clique para pagar',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: Color(CustomColor.BlueNormal),
                  ),
                ),
                Text(
                  'R\$ ${financeViewModel.netValue}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Color(CustomColor.GrayDark),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Modal extends StatelessWidget {
  final FinanceViewModel financeViewModel;

  const Modal({Key? key, required this.financeViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
          Container(
            alignment: Alignment.topRight,
            width: size.width * 0.5,
            child: Text(
              data,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Color(CustomColor.GrayDark),
                overflow: TextOverflow.ellipsis,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    Widget button(String label) {
      return Container(
        width: size.width * 0.4,
        height: 42.0,
        decoration: BoxDecoration(
          color: Color(CustomColor.OrangeDark),
          borderRadius: BorderRadius.circular(22.0),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Color(CustomColor.OrangeDark),
          ),
          onPressed: () {},
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Color(CustomColor.White),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 20.0,
      ),
      width: size.width,
      color: Color(CustomColor.WhiteLight),
      child: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Informações Adicionais',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: Color(CustomColor.BlueNormal),
                    ),
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () => Navigator.pop(context),
                iconSize: 24.0,
                icon: Icon(Icons.close),
                color: Color(CustomColor.BlueNormal),
              ),
            ],
          ),
          SizedBox(
            height: 22.0,
          ),
          item('Serviço', financeViewModel.service),
          SizedBox(
            height: 6.0,
          ),
          item('Responsável', financeViewModel.responsible),
          SizedBox(
            height: 6.0,
          ),
          item('Situação', financeViewModel.status),
          SizedBox(
            height: 6.0,
          ),
          item(
              'Vencimento',
              DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(financeViewModel.dueDate))),
          SizedBox(
            height: 6.0,
          ),
          item('Período Letivo', '2021S2'),
          SizedBox(
            height: 6.0,
          ),
          item(
              'Competência',
              DateFormat('MM/yyyy')
                  .format(DateTime.parse(financeViewModel.competence))),
          SizedBox(
            height: 6.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Valor Bruto',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Color(CustomColor.GrayDark),
                ),
              ),
              Text(
                'R\$ ${financeViewModel.grossValue}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(CustomColor.GrayDark),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bolsa Incondicional',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Color(CustomColor.GrayDark),
                ),
              ),
              Text(
                'R\$ ${financeViewModel.scholarshipInconditional}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(CustomColor.GrayDark),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Valor a pagar',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(CustomColor.BlueNormal),
                ),
              ),
              Text(
                'R\$ ${financeViewModel.netValue}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(CustomColor.OrangeNormal),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              button('Boleto'),
              button('Cartão'),
            ],
          ),
        ],
      ),
    );
  }
}
