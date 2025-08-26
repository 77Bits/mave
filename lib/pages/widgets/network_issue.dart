import 'package:flutter/material.dart';




class NetworkIssueRetryWidget extends StatelessWidget{
  final Function() retryFuntion;
  final String     msg;

  NetworkIssueRetryWidget(this.retryFuntion, [this.msg="Retry", Key? key]): super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize:MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off_rounded),
          Text("Network Issue"),
          TextButton(
            onPressed: retryFuntion,
            child    : Text(msg),
          )
        ],
      ),
    );
  }
}
