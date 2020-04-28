import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:j3enterprise/src/database/moor_database.dart';
import 'package:j3enterprise/src/resources/shared/icons/custom_icons.dart';
import 'package:j3enterprise/src/resources/shared/lang/appLocalization.dart';
import 'package:j3enterprise/src/resources/shared/widgets/dropdown_box.dart';
import 'package:j3enterprise/src/resources/shared/widgets/text_field_nullable.dart';

import 'bloc/communication_bloc.dart';

class SetupCommunicationForm extends StatefulWidget {
  @override
  State<SetupCommunicationForm> createState() => _SetupCommunicationForm();
}

class _SetupCommunicationForm extends State<SetupCommunicationForm> {
  final formKey = new GlobalKey<FormState>();

  //Drop down setting
  var erpSelecteditem;
  var syncfrequencySelectedItem;

  //ERP Communication setting
  final _typeoferpController = TextEditingController();
  final _serverurlController = TextEditingController();
  final _usernameController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  //final _syncfrequncyController = TextEditingController();

  //API comeunication Setting

  void submitForm(CommunicationBloc bloc) {
    var formData = ComssetData(
      id: 0,
      serverurl: _serverurlController.value.text,
      username: _usernameController.value.text,
      newpasskey: "123hhh",
      confirmpasskey: _confirmpasswordController.value.text,
      syncfrequency: syncfrequencySelectedItem,
      typeoferp: erpSelecteditem,
      commtype: _typeoferpController.value.text,
    );

    var event = SaveCammunicationButtonPressed(data: formData);
    bloc.add(event);
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CommunicationBloc>(context);

    return Form(
      key: formKey,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(CustomIcons.wrench_solid),
                  text: AppLocalization.of(context)
                      .translate('tab_communication_communication'),
                ),
                Tab(
                  icon: Icon(CustomIcons.cog_regular),
                  text: AppLocalization.of(context)
                      .translate('tab_api_communication'),
                )
              ],
            ),
            title: Text(
                AppLocalization.of(context).translate('title_communication')),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.file_download, size: 40, color: Colors.yellow),
                  ],
                ),
              )
            ],
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(0.00),
                        child: DropdownFormFieldNormalReuse(
                          hintText: AppLocalization.of(context)
                              .translate('type_of_erp_label_communication'),
                          selectedValue: erpSelecteditem,
                          listData: ['SAP', 'ERP Next', 'Quick Books'],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(0.00),
                      child: TextFromFieldNullableReusable(
                        labelName: AppLocalization.of(context)
                            .translate('server_url_label_communication'),
                        controllerName: _serverurlController,
                        validationText: 'Test',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.00),
                      child: TextFromFieldNullableReusable(
                        labelName: AppLocalization.of(context)
                            .translate('username_label_communication'),
                        controllerName: _usernameController,
                        validationText: 'Test',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.00),
                      child: TextFromFieldNullableReusable(
                        labelName: AppLocalization.of(context)
                            .translate('new_password_label_communication'),
                        validationText: 'Test',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.00),
                      child: TextFromFieldNullableReusable(
                        labelName: AppLocalization.of(context)
                            .translate('confirm_password_label_communication'),
                        controllerName: _confirmpasswordController,
                        validationText: 'Test',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.00),
                      child: DropdownFormFieldNormalReuse(
                        hintText: AppLocalization.of(context)
                            .translate('sync_frequency_label_communication'),
                        selectedValue: syncfrequencySelectedItem,
                        listData: [
                          'Every Minet',
                          'Every 5 Minutes',
                          'Every 20 Minutes',
                          'Every Day',
                          'Every Month',
                          'Every Year'
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.00),
                      child: ButtonTheme(
                        height: 50,
                        child: FlatButton(
                          color: Colors.green[400],
                          onPressed: () {
                            submitForm(bloc);
                          },
                          child: Center(
                              child: Text(
                            AppLocalization.of(context)
                                .translate('save_changes_button_serversetup'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  //ToDo Implemet texteditor for API
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
