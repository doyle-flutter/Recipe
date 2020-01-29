import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder/data.dart';
import 'package:intl/intl.dart';

import 'result.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Builder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  
  final DateTime startDate = DateTime.now();
  
  bool autovalidate = false;

  void _submit() {
    setState(() {
      autovalidate = true;
    });

    if (!_fbKey.currentState.validate()) {
      return;
    }

    _fbKey.currentState.save();
    final inputValues = _fbKey.currentState.value;

  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Builder Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 20,
              ),
              child: FormBuilder(
                key: _fbKey,
                autovalidate: autovalidate,
                child: Column(
                  children: <Widget>[
                    FormBuilderDateTimePicker(
                      attribute: 'startDate',
                      inputType: InputType.date,
                      initialValue: startDate,
                      firstDate: startDate,
                      lastDate: DateTime(
                          startDate.year + 1, startDate.month, startDate.day),
                      format: DateFormat('yyyy-MM-dd'),
                      decoration: InputDecoration(
                        filled: true,
                        labelText: '시작일',
                        border: OutlineInputBorder(),
                      ),
                      validators: [
                        FormBuilderValidators.required(
                          errorText: '시작일은 필수입니다',
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    FormBuilderDateTimePicker(
                      attribute: 'endDate',
                      inputType: InputType.date,
                      initialValue: startDate,
                      firstDate: startDate,
                      lastDate: DateTime(
                          startDate.year + 1, startDate.month, startDate.day),
                      format: DateFormat('yyyy-MM-dd'),
                      decoration: InputDecoration(
                        filled: true,
                        labelText: '종료일',
                        border: OutlineInputBorder(),
                      ),
                      validators: [
                        FormBuilderValidators.required(
                          errorText: '종료일은 필수입니다',
                        ),
                        (val) {
                          print(val is DateTime);
                          final sd = _fbKey.currentState.fields['startDate']
                              .currentState.value;

                          if (sd != null && sd.isAfter(val)) {
                            return '시작일이 종료일보다 뒤입니다';
                          }
                          return null;
                        }
                      ],
                    ),
                    SizedBox(height: 20),
                    FormBuilderDropdown(
                      attribute: 'cropId',
                     // items: crops.map<DropdownMenuItem<String>>((crop) {
                       // return DropdownMenuItem<String>(
                       //     value: crop['id'], child: Text(crop['cropName']));
                     // }).toList(),
                      hint: Text('선택하세요'),
                      decoration: InputDecoration(
                        filled: true,
                        labelText: '선택',
                        border: OutlineInputBorder(),
                      ),
                      validators: [
                        FormBuilderValidators.required(
                          errorText: '필수선택입니다',
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    FormBuilderTextField(
                      attribute: 'area',
                      decoration: InputDecoration(
                        filled: true,
                        labelText: '숫자 입력',
                        hintText: '숫자 입력하세요',
                        border: OutlineInputBorder(),
                      ),
                      validators: [
                        FormBuilderValidators.required(errorText: '필수입니다'),
                        FormBuilderValidators.numeric(errorText: '숫자 입력하세요'),
                        (val) {
                          final value = double.parse(val);
                          print(value)
                        }
                      ],
                    ),
                    SizedBox(height: 20),
                    FormBuilderRadio(
                      attribute: 'urgent',
                      decoration: InputDecoration(
                        filled: true,
                        labelText: '택1',
                        border: OutlineInputBorder(),
                      ),
                      validators: [
                        FormBuilderValidators.required(
                          errorText: '둘중하나 선택하세요',
                        ),
                      ],
                      options: ['1', '2']
                          .map(
                            (u) => FormBuilderFieldOption(value: u),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 20),
                    FormBuilderCheckboxList(
                      attribute: 'warning',
                      leadingInput: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.amberAccent,
                        labelText: '주의사항',
                        border: OutlineInputBorder(),
                      ),
                      validators: [
                        (val) {
                          if (val.length != 2) {
                            return '전부 동의하셔야 합니다';
                          }
                          return null;
                        }
                      ],
                      options: [
                        FormBuilderFieldOption(value: '약관1'),
                        FormBuilderFieldOption(value: '약관2'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: _submit,
                  color: Colors.indigo,
                  textColor: Colors.white,
                  minWidth: 120,
                  height: 45,
                ),
                MaterialButton(
                  child: Text(
                    'RESET',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    _fbKey.currentState.reset();
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  minWidth: 120,
                  height: 45,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
