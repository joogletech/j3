import 'package:flutter/material.dart';
import 'package:j3enterprise/src/resources/shared/icons/custom_icons.dart';
import 'package:j3enterprise/src/resources/shared/lang/appLocalization.dart';
import 'package:j3enterprise/src/ui/communication/widget/communication_tab_erp_widget.dart';
import 'package:j3enterprise/src/ui/communication/widget/communication_tab_api_widget.dart';

import 'background_fetch_page.dart';
import 'backgroundjobs_page.dart';
import 'backgroundjobs_pages.dart';

class SetupBackgroundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                text:
                    AppLocalization.of(context).translate('tab_app_servies') ??
                        'App Servies',
              ),
              Tab(
                icon: Icon(CustomIcons.cog_regular),
                text: AppLocalization.of(context)
                        .translate('tab_device_servies') ??
                    'Device Serives',
              )
            ],
          ),
          title: Text(
              AppLocalization.of(context).translate('title_background_jobs') ??
                  'Background Jobs'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Icon(Icons.cloud_download, size: 40, color: Colors.white),
                ],
              ),
            )
          ],
        ),
        body: TabBarView(
          children: [
            //Tab 1
            BackgroundFetchPage(),
            //Tab 2
            BackgroundJobsPage()
          ],
        ),
      ),
    );
  }
}