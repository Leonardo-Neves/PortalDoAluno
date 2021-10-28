import 'package:flutter/material.dart';

// App
import 'package:projeto/base_widget.dart';
import 'package:projeto/modules/CustomColor.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Controller
import 'package:projeto/controller/requirements.controller.dart';

// View
import 'package:projeto/views/requirements.dart';

class RequirementsMessage extends StatefulWidget {
  RequirementsMessage({Key? key}) : super(key: key);

  @override
  _RequirementsMessageState createState() => _RequirementsMessageState();
}

class _RequirementsMessageState extends State<RequirementsMessage> {
  Future<dynamic> _navegateToRequirements() async {
    return await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => Requirements(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseWidget(
      model: RequirementsController(
        api: Provider.of(context),
      ),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 3 / 2,
                  child: SvgPicture.asset(
                    'asset/image/requirementsmessage.svg',
                    width: size.width * 0.8,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Atendimento Realizado',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: Color(CustomColor.BlueNormal),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    'O atendimento foi realizado, agora pague a taxa solicitada para finalizar o processo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Color(CustomColor.GrayDark),
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.link,
                          size: 24.0,
                          color: Color(CustomColor.OrangeNormal),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Pagar Taxa',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(CustomColor.OrangeNormal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 1.0,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Color(CustomColor.GrayDark).withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Ou'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      height: 1.0,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Color(CustomColor.GrayDark).withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: () {
                    _navegateToRequirements();
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    'Finalizar Atendimento',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(CustomColor.OrangeNormal),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
