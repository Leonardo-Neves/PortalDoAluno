import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// App
import 'package:projeto/base_widget.dart';
import 'package:projeto/modules/components.dart';
import 'package:projeto/modules/CustomColor.dart';

// Controller
import 'package:projeto/controller/requirements.controller.dart';

// Packages
import 'package:provider/provider.dart';

// View
import 'package:projeto/views/requirementsmessage.dart';

// View Model
import 'package:projeto/view-models/attendment.viewmodel.dart';
import 'package:projeto/view-models/requirements.viewmodel.dart';
import 'package:projeto/view-models/itemrequirement.viewmodel.dart';

// Packages
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:async/async.dart';

class NewRequirements extends StatefulWidget {
  final AttendmentViewModel attendmentViewModel;
  NewRequirements({Key? key, required this.attendmentViewModel})
      : super(key: key);

  @override
  _NewRequirementsState createState() => _NewRequirementsState();
}

class _NewRequirementsState extends State<NewRequirements> {
  int selectedIndexUnits = 0;
  var solicitationTextInputController;
  var student;
  final _formNewRequirementKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      RequirementsController requirementsController =
          new RequirementsController(api: Provider.of(context, listen: false));

      student = requirementsController.getStudent();
    });
    solicitationTextInputController = TextEditingController();
  }
  /*
  Future<void> uploadImage(File file, String filename) async {
    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/requirement',
    );
    var request = http.MultipartRequest('POST', url);

    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.headers.addAll(headers);
    /*
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        (await rootBundle.load(file.path)).buffer.asUint8List(),
        filename: filename,
      ),
    );
    */

    //request.files.add(await http.MultipartFile.fromPath('picture', filename));

    var res = await request.send();
    //return res.reasonPhrase;
  }

  upload(File file, String filename) async {
    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/requirement',
    );

    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();

    var request = new http.MultipartRequest("POST", url);

    var multipartFile = new http.MultipartFile(
      'file',
      stream,
      length,
      filename: filename,
    );
    request.files.add(multipartFile);

    var response = await request.send();


  }
  

  upload(File file, String filename) async {
    FormData formData = new FormData.fromMap({
      'name': 'Leonardo',
      'file': await MultipartFile.fromFile(file.path, filename: filename)
    });

    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/requirement',
    );

    Response response = await Dio().post(
        'https://leonardoneves.free.beeceptor.com/my/api/path',
        data: formData);
  }
  */

  upload(File file, String filename) async {
    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/requirement',
    );

    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();

    var request = new http.MultipartRequest("POST", url);

    var multipartFile = new http.MultipartFile(
      'file',
      stream,
      length,
      filename: filename,
    );
    print('1');
    request.files.add(multipartFile);

    var response = await request.send();
  }

  @override
  void dispose() {
    solicitationTextInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BaseWidget<RequirementsController>(
      model: RequirementsController(api: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        appBar: Header(
          title: 'Requerimentos',
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: BoxDecoration(
            color: Color(CustomColor.WhiteLight),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Requerimento',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(CustomColor.BlueNormal),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.attendmentViewModel.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                    'Descrição',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(CustomColor.BlueNormal),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.attendmentViewModel.description,
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
                    'Aceite',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(CustomColor.BlueNormal),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.attendmentViewModel.accept,
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
                    'Unidades*',
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
                    height: 42.0,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 12.0,
                        );
                      },
                      itemCount: widget.attendmentViewModel.units.length,
                      shrinkWrap: true,
                      primary: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InputChip(
                          padding: const EdgeInsets.all(10.0),
                          backgroundColor: selectedIndexUnits == index
                              ? Color(CustomColor.OrangeNormal)
                              : Color(CustomColor.White),
                          selectedColor:
                              selectedIndexUnits == index ? Colors.red : null,
                          label: Text(
                            '${widget.attendmentViewModel.units[index]}',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: selectedIndexUnits == index
                                  ? Color(CustomColor.White)
                                  : Color(CustomColor.GrayDark),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedIndexUnits = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Solicitação*',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(CustomColor.BlueNormal),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Form(
                    key: _formNewRequirementKey,
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      height: 122.0,
                      decoration: BoxDecoration(
                        color: Color(CustomColor.White),
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      child: TextFormField(
                        controller: solicitationTextInputController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(CustomColor.GrayDark),
                        ),
                        maxLines: 8,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Escreva sua solicitação',
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
                          errorStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Color(CustomColor.BlueNormal),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a situação';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Arquivos',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Color(CustomColor.BlueNormal),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            File file = File('${result.files.single.path}');
                            PlatformFile filee = result.files.first;

                            await upload(file, filee.name);
                          }
                        },
                        icon: Icon(Icons.attachment),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  widget.attendmentViewModel.price != 0
                      ? Text(
                          '*Para esse atendimento será necessário o pagamento de uma taxa, que estara disponível após essa primeira etapa',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(CustomColor.GrayDark),
                          ),
                        )
                      : Text(''),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Valor do atendimento',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(CustomColor.BlueNormal),
                        ),
                      ),
                      Text(
                        widget.attendmentViewModel.price != 0
                            ? 'R\$ ${widget.attendmentViewModel.price}'
                            : 'Gratuito',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Color(CustomColor.OrangeNormal),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.0),
                      color: Color(CustomColor.OrangeNormal),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (model.busy == false) {
                          if (_formNewRequirementKey.currentState!.validate()) {
                            model.setBusy(false);
                            ItemRequirementViewModel itemRequirementViewModel =
                                new ItemRequirementViewModel(
                                    solicitationTextInputController.text);
                            RequirementViewModel requirementViewModel =
                                new RequirementViewModel(
                              student.id,
                              '',
                              'GESTÃO ACADEMICA ANALISA',
                              'Em andamento',
                              [solicitationTextInputController.text],
                              new AttendmentViewModel(
                                widget.attendmentViewModel.id,
                                widget.attendmentViewModel.name,
                                widget.attendmentViewModel.type,
                                widget.attendmentViewModel.price,
                                widget.attendmentViewModel.description,
                                widget.attendmentViewModel.units,
                                widget.attendmentViewModel.accept,
                                widget.attendmentViewModel.procedure,
                              ),
                              widget.attendmentViewModel
                                  .units[selectedIndexUnits],
                            );

                            model.postRequirements(
                                requirementViewModel, context);
                          }
                        }
                      },
                      child: model.busy == true
                          ? SizedBox(
                              height: 28.0,
                              width: 28.0,
                              child: CircularProgressIndicator(
                                color: Color(CustomColor.White),
                              ),
                            )
                          : Text(
                              'Solicitar Atendimento',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Color(CustomColor.White),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
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
