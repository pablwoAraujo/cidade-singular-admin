import 'dart:io';

import 'package:cidade_singular_admin/app/screens/singularities/address_search.dart';
import 'package:cidade_singular_admin/app/services/singularity_service.dart';
import 'package:cidade_singular_admin/app/stores/user_store.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddSingularityPage extends StatefulWidget {
  const AddSingularityPage({Key? key}) : super(key: key);

  static String routeName = "/add_singularity";

  @override
  _AddSingularityPageState createState() => _AddSingularityPageState();
}

class _AddSingularityPageState extends State<AddSingularityPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleTextEdtCtrl = TextEditingController();
  TextEditingController descriptionTextEdtCtrl = TextEditingController();
  TextEditingController addressTextEdtCtrl = TextEditingController();
  TextEditingController visitingHoursTextEdtCtrl = TextEditingController();

  UserStore userStore = Modular.get();

  SingularityService singularityService = Modular.get();

  final ImagePicker picker = ImagePicker();

  List<XFile> images = [];

  void pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        images.add(image);
      });
    }
  }

  bool validateImages() {
    setState(() {
      validImages = images.isNotEmpty;
    });
    return validImages;
  }

  double? lat;
  double? lng;

  bool validImages = true;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar singularidade"),
        leading: BackButton(
          onPressed: () => Modular.to.pop(false),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFormField(title: "Título", controller: titleTextEdtCtrl),
                SizedBox(height: 16),
                buildFormField(
                  title: "Descrição",
                  controller: descriptionTextEdtCtrl,
                  minLines: 10,
                ),
                SizedBox(height: 16),
                buildFormField(
                  title: "Endereço",
                  controller: addressTextEdtCtrl,
                  readOnly: true,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      "assets/images/places.svg",
                      width: 10,
                      fit: BoxFit.contain,
                    ),
                  ),
                  onTap: () async {
                    final sessionToken = Uuid().v4();
                    final result = await showSearch(
                      context: context,
                      delegate: AddressSearch(sessionToken),
                      query: addressTextEdtCtrl.text,
                    );
                    if (result != null) {
                      setState(() {
                        addressTextEdtCtrl.text = result.description;
                        lat = result.lat;
                        lng = result.lng;
                      });
                    }
                  },
                ),
                SizedBox(height: 16),
                buildFormField(
                  title: "Horário de visitação",
                  controller: visitingHoursTextEdtCtrl,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      "assets/images/hour.svg",
                      width: 10,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Fotos",
                  style: TextStyle(
                    fontSize: 18,
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Constants.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ...images.map(
                        (image) => SizedBox(
                          width: 100,
                          height: 100,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(image.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -5,
                                right: -5,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      images.remove(image);
                                    });
                                  },
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.deepOrange.shade300,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white70,
                          ),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontSize: 36,
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (!validImages)
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 16),
                    child: Text(
                      "Adicione ao menos uma foto!",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                Center(
                  child: loading
                      ? Center(child: CircularProgressIndicator())
                      : GestureDetector(
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            if ((_formKey.currentState?.validate() ?? false) &&
                                validateImages()) {
                              bool added =
                                  await singularityService.addSingularity(
                                title: titleTextEdtCtrl.text,
                                description: descriptionTextEdtCtrl.text,
                                address: addressTextEdtCtrl.text,
                                type: userStore.user?.curator_type
                                        .toString()
                                        .split('.')
                                        .last ??
                                    "",
                                visitingHours: visitingHoursTextEdtCtrl.text,
                                photos: images,
                                lat: lat ?? 0,
                                lng: lng ?? 0,
                              );

                              if (added) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.green.shade800,
                                    content: Text(
                                      "Singularidade cadastrada com sucesso!",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                                await Future.delayed(
                                    Duration(milliseconds: 1000));
                                Modular.to.pop(true);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red.shade800,
                                    content: Text(
                                      "Ops, algo deu errado!",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                                await Future.delayed(
                                    Duration(milliseconds: 500));
                              }
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Constants.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white38,
                                  blurRadius: 2,
                                  offset: Offset(2, 2),
                                )
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              "Adicionar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFormField({
    String? title,
    required TextEditingController controller,
    int minLines = 1,
    String? Function(String?)? validator,
    void Function()? onTap,
    bool readOnly = false,
    Widget? prefixIcon,
    TextStyle? titleStyle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title,
            style: titleStyle ??
                TextStyle(
                  fontSize: 18,
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        TextFormField(
          onTap: onTap,
          readOnly: readOnly,
          controller: controller,
          validator: validator ?? emptyValidator,
          textAlign: TextAlign.justify,
          maxLines: null,
          minLines: minLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: "",
            counterText: "",
            helperMaxLines: 0,
            filled: true,
            fillColor: Constants.grey,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }

  String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo não pode ser vazio";
    }
    return null;
  }
}
