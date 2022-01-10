import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar singularidade"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildFormField(title: "Título", controller: titleTextEdtCtrl),
                SizedBox(height: 16),
                buildFormField(
                  title: "Descrição",
                  controller: descriptionTextEdtCtrl,
                  maxLines: 10,
                ),
                SizedBox(height: 16),
                buildFormField(
                  title: "Endereço",
                  controller: addressTextEdtCtrl,
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                buildFormField(
                  title: "Horários",
                  controller: visitingHoursTextEdtCtrl,
                  maxLines: 1,
                ),
                SizedBox(height: 20),
                Container(
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Text(
                    "Adicionar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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

  Widget buildFormField(
      {required String title,
      required TextEditingController controller,
      int maxLines = 1,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Constants.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: controller,
          validator: validator ?? emptyValidator,
          textAlign: TextAlign.center,
          maxLines: maxLines,
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
