import 'package:f08_eshop_app/model/request_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RequestList>(context, listen: false).fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
      ),
      body: Consumer<RequestList>(
        builder: (context, requestList, child) {
          if (requestList.requests.isEmpty) {
            return Center(child: Text("Nenhum pedido encontrado"));
          }

          return ListView.builder(
            itemCount: requestList.requests.length,
            itemBuilder: (context, index) {
              final request = requestList.requests[index];
              return ListTile(
                title: Text('Pedido: ${request.id}'),
                subtitle: Text('Endereço: ${request.address}'),
                trailing: Text('Valor: ${request.value}'),
              );
            },
          );
        },
      ),
    );
  }
}
