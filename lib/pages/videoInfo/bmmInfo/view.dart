
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class BmmInfoPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider(
            create: (BuildContext context) => BmmInfoProvider(context),
            builder: (context, child) => _buildPage(context),
        );
    }

    Widget _buildPage(BuildContext context) {
        final p = context.read<BmmInfoProvider>();
        final pp = Provider.of<BmmInfoProvider>(context,listen: true);
        p.init();
        return Container();
    }
}