import 'package:flutter/material.dart';

// App
import 'package:projeto/base_widget.dart';
import 'package:projeto/modules/components.dart';
import 'package:projeto/modules/CustomColor.dart';

// Controller
import 'package:projeto/controller/requirements.controller.dart';

// View Model
import 'package:projeto/view-models/requirements.viewmodel.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RequirementsDetails extends StatefulWidget {
  final RequirementViewModel requirementViewModel;
  RequirementsDetails({Key? key, required this.requirementViewModel})
      : super(key: key);

  @override
  _RequirementsDetailsState createState() => _RequirementsDetailsState();
}

class _RequirementsDetailsState extends State<RequirementsDetails> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<RequirementsController>(
      model: RequirementsController(
        api: Provider.of(context),
      ),
      builder: (context, model, child) => Scaffold(
        appBar: Header(
          title: 'Requerimentos',
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: Color(CustomColor.WhiteLight),
            ),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Requerimento',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(CustomColor.BlueNormal),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      widget.requirementViewModel.attendment.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Color(CustomColor.OrangeNormal),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Informações',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Color(CustomColor.BlueNormal),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ItemInformation(
                      label: 'N° Protocolo',
                      value: widget.requirementViewModel.protocolNumber,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ItemInformation(
                      label: 'Status',
                      value: widget.requirementViewModel.status,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ItemInformation(
                      label: 'Abertura',
                      value:
                          '${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.requirementViewModel.createdDate.toString()))}',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ItemInformation(
                      label: 'Etapa Atual',
                      value:
                          '${widget.requirementViewModel.step}ashdoisahdoashdoihadsoihiaosd',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Discussão',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Color(CustomColor.BlueNormal),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    /*
                    ItemResponse(
                      label: 'Em 23/09/2021 11:35',
                      value: widget.requirementViewModel.solicitation,
                    ),
                    */
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Solução',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Color(CustomColor.BlueNormal),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    /*
                    ItemResponse(
                      label: 'Em 23/09/2021 11:35',
                      value: widget.requirementViewModel.solicitation,
                    ),
                    */
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Arquivos',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Color(CustomColor.BlueNormal),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CardFile(
                      fileName: 'LEONARDO SILVA NEVES.pdf',
                      fileSize: '48,03 KB',
                    ),
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

class ItemInformation extends StatelessWidget {
  final String label;
  final String value;
  const ItemInformation({Key? key, this.label = '', this.value = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          width: size.width * 0.6,
          alignment: Alignment.topRight,
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Color(CustomColor.GrayDark),
            ),
          ),
        ),
      ],
    );
  }
}

class ItemResponse extends StatelessWidget {
  final String label;
  final String value;
  const ItemResponse({
    Key? key,
    this.label = '',
    this.value = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Color(CustomColor.OrangeNormal),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Color(CustomColor.GrayDark),
          ),
        ),
      ],
    );
  }
}

class CardFile extends StatelessWidget {
  final String fileName;
  final String fileSize;
  const CardFile({Key? key, this.fileName = '', this.fileSize = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(CustomColor.White),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fileName,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Color(CustomColor.OrangeNormal),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Tamanho: $fileSize',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Color(CustomColor.GrayDark).withOpacity(0.6),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.file_download,
              size: 22.0,
              color: Color(CustomColor.BlueNormal),
            ),
          ),
        ],
      ),
    );
  }
}
