import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_travel_ui/UI/screens/checkout_screen.dart';
import 'package:flutter_travel_ui/UI/screens/login_screen.dart';
import 'package:flutter_travel_ui/blocs/auth/auth_bloc.dart';
import 'package:flutter_travel_ui/blocs/booking_bloc.dart';
import 'package:flutter_travel_ui/models/booking_model.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:flutter_travel_ui/networking/response.dart';
import 'package:flutter_travel_ui/repository/booking_repository.dart';
import 'package:flutter_travel_ui/repository/tour_repository.dart';
import 'package:flutter_travel_ui/widgets/button.dart';
import 'package:flutter_travel_ui/widgets/response_widget.dart';
import 'package:flutter_travel_ui/widgets/ticket_widget.dart';
import 'package:intl/intl.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  BookingBloc _bloc;

  getToken() async {
    final _storage = FlutterSecureStorage();
    return await _storage.read(key: "token");
  }
 final formatter = new NumberFormat("#,###");
  @override
  void initState() {
    super.initState();
    _bloc = BookingBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthFailure) return _unSignInScreen();
      if (state is AuthSuccess) return cartScreen();

      return _loadingScreen();
    });
  }

  cartScreen() {
    final _storage = FlutterSecureStorage();
    _storage.read(key: "token").then((value) => _bloc.fetchCart(value));
    return StreamBuilder<Response<Booking>>(
      stream: _bloc.bookingDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              print('loading');
              return Loading(loadingMessage: snapshot.data.message);
              break;
            case Status.COMPLETED:
              print('completed');
              return _cartPage(snapshot);
              break;
            case Status.ERROR:
              return Error(
                errorMessage: snapshot.data.message,
              );
              break;
          }
        }
        return Container();
      },
    );
  }

  _cartPage(snapshot) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ticket'),
          centerTitle: true,
        ),
        bottomNavigationBar: InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => CheckoutScreen())),
          child: Container(
            height: 80,
            width: double.infinity,
            color: Colors.lightBlue,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(
                '${formatter.format(snapshot.data.data.total)} VND\nĐẶT HÀNG',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: snapshot.data.data.bookingItems.length,
          itemBuilder: (BuildContext context, int index) {
            return TicketItem(item: snapshot.data.data.bookingItems[index]);
          },
        ));
  }

  _unSignInScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.ideographic,
        children: <Widget>[
          Center(
            child: Text(
              'Bạn phải đăng nhập để có thể sử dụng chức năng này!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          GreenGradientButton(
            text: 'Đăng nhập / Đăng ký'.toUpperCase(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

_loadingScreen() {
  return Center(
      child: CupertinoActivityIndicator(
    radius: 50,
  ));
}
