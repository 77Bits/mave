import 'dart:io';
import 'package:flutter/material.dart';
import 'widgets.dart' show ComicGrid, NetworkIssueRetryWidget;
import 'package:mave/modules/modules.dart' show Comic, ComicLabel;
import 'package:mave/modules/fetch.dart' as fetch;







class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  
  Future<void> _future = fetch.fillEmptyDatabase();
  int          _page   = 0;
  List<Comic>  _comics = [];

  Map<String, ComicLabel> _comicLabel = {};

  final ScrollController _viewController = ScrollController();
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await _refresh(context),
        child: FutureBuilder(
          future : _future,
          builder: _snapshotBuilder,
        ),
      ) 
    );
  }


  Future<void> _refresh(BuildContext context) async{
    try{
      final newComicLabel = await fetch.updateComics();
      setState(() {
        _comicLabel = newComicLabel;
      });
      
    } on SocketException{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network Issue'),
        )
      );
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unknown Error'),
        )
      );
    }
  }



  @override
  void initState() {
    super.initState();
    _viewController.addListener(_viewListener);
  }


  void _viewListener(){
    if (_viewController.position.pixels >= _viewController.position.maxScrollExtent - 400){
        _fillViewer();
    }
  }

  void _fillViewer() async{
    final dbResult = await fetch.loadComics(_page++);
    if (dbResult.isEmpty){
      _viewController.removeListener(_viewListener);
      return ;
    }
    setState(() {
      _comics.addAll(dbResult);
    });
  }
  

  Widget _snapshotBuilder(BuildContext context, AsyncSnapshot<void> snapshot){
    if (snapshot.connectionState == ConnectionState.done){
      if (!snapshot.hasError){
        if (_comics.isEmpty) _fillViewer();
        return ComicGrid(
          comics    : _comics,
          controller: _viewController,
          comicLabel: _comicLabel,
        );
      }

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






