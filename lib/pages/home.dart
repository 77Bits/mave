import 'dart:io';
import 'package:flutter/material.dart';
import 'widgets.dart' show ComicGrid, NetworkIssueRetryWidget;
import 'package:mave/toolkit/toolkit.dart' show Comic;
import 'package:mave/toolkit/fetch.dart' as fetch;







class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  
  Future<void> _future = fetch.fillEmptyDatabase();

  Widget? _appBarTail;

  final ScrollController _viewController = ScrollController();
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future : _future,
        builder: _snapshotBuilder,
      ),
    );
  }
  

  Widget _snapshotBuilder(BuildContext context, AsyncSnapshot<void> snapshot){
    if (snapshot.connectionState == ConnectionState.done){
      if (!snapshot.hasError) return ComicGrid([]);

      final error = snapshot.error!;
      if (error is SocketException)
        return NetworkIssueRetryWidget(_retry);
      else
        return Text(snapshot.error.toString());
    }
    return _circularProgressIndCentered;
  }


  void _retry(){
    setState(() {
       _future = fetch.fillEmptyDatabase();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _viewController.dispose();
  }
}

const _circularProgressIndCentered = Center(
  child: CircularProgressIndicator()
);






