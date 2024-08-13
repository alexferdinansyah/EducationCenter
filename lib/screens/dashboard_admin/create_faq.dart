import 'package:flutter/material.dart';
import 'package:project_tc/models/faq.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:provider/provider.dart';

class CreateFAQ extends StatefulWidget {
  const CreateFAQ({super.key});

  @override
  State<CreateFAQ> createState() => _CreateFAQState();
}

class _CreateFAQState extends State<CreateFAQ> {
  final _formKey = GlobalKey<FormState>();
  String _question = '';
  String _answer = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    double width = MediaQuery.of(context).size.width;

    void _submitForm() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Processing Data')),
        );
        if (_question.isNotEmpty && _answer.isNotEmpty) {
          print('Name: $_question');
          print('Email: $_answer');
          final FirestoreService firestore = FirestoreService(uid: user!.uid);
          final faqData = Faq(question: _question, answer: _answer);
          final res = await firestore.createFAQ(faqData);
          print(res!);
        }
      }
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
          getValueForScreenType<double>(
            context: context,
            mobile: 15,
            tablet: 15,
            desktop: 40,
          ),
          getValueForScreenType<double>(
            context: context,
            mobile: 15,
            tablet: 15,
            desktop: 40,
          ),
          getValueForScreenType<double>(
            context: context,
            mobile: 15,
            tablet: 15,
            desktop: 40,
          ),
          10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: GestureDetector(
                    onTap: () => Get.rootDelegate.offNamed(routeFAQ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: getValueForScreenType<double>(
                        context: context,
                        mobile: 18,
                        tablet: 22,
                        desktop: 24,
                      ),
                    )),
              ),
              const Text('Create FAQ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
          SizedBox(
            width: width * 0.7,
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Grey border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none, // Remove default border
                            labelText: 'Question',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the question';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _question = newValue ?? '';
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Grey border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none, // Remove default border
                            labelText: 'Answer',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Answer';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _answer = newValue ?? '';
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Submit'),
                      ),
                    ])),
          )
        ],
      ),
    );
  }
}
