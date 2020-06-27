import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_travel_ui/UI/pages/search_page.dart';
import 'package:flutter_travel_ui/UI/screens/login_screen.dart';
import 'package:flutter_travel_ui/blocs/tour_bloc.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:flutter_travel_ui/networking/response.dart';
import 'package:flutter_travel_ui/repository/booking_repository.dart';
import 'package:flutter_travel_ui/widgets/response_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:toast/toast.dart';

class TourDetailScreen extends StatefulWidget {
  final String tourId;

  TourDetailScreen({this.tourId});

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  BookingRepository _bookingRepository = new BookingRepository();

  final formatter = new NumberFormat("#,###");
  var qtt = 1;
  var isAdult = true;
  TourBloc _bloc;
  getToken() async {
    final _storage = FlutterSecureStorage();
    return await _storage.read(key: "token");
  }

  @override
  void initState() {
    super.initState();
    _bloc = TourBloc();
    _bloc.fetchTourById(widget.tourId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () async {
            String token = await getToken();
         
            if (token == null) {
              showCupertinoSheet(context, 'Yêu cầu đăng nhập',
                  'Để sử dụng tính năng giỏ hàng yêu cầu bạn phải đăng nhập?');
            } else {
              var type = isAdult ? "adult" : "child";
              await _bookingRepository.addTourToCart(
                  token, widget.tourId, type, qtt);
              Toast.show('Thêm giỏ hàng thành công!', context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
          },
          child: Icon(Icons.add_shopping_cart),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchTourById(widget.tourId),
        child: StreamBuilder<Response<Tour>>(
          stream: _bloc.tourDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return _tourDetail(context, snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchTourById(widget.tourId),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  _tourDetail(context, Tour tour) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image(
                    image: NetworkImage(tour.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.search),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage())),
                        ),
                        // IconButton(
                        //   icon: Icon(FontAwesomeIcons.sortAmountDown),
                        //   iconSize: 25.0,
                        //   color: Colors.black,
                        //   onPressed: () => Navigator.pop(context),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tour.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.moneyBill,
                          size: 15.0,
                          color: Colors.white70,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          '${formatter.format(tour.childPrice)} - ${formatter.format(tour.adultPrice)} VND',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20.0,
                bottom: 20.0,
                child: Icon(
                  Icons.location_on,
                  color: Colors.white70,
                  size: 25.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlineButton(
                  child: Text('Người lớn'),
                  disabledBorderColor: Colors.green,
                  onPressed: !isAdult
                      ? () {
                          setState(() {
                            isAdult = !isAdult;
                            print(isAdult);
                          });
                        }
                      : null,
                ),
                OutlineButton(
                  child: Text('Trẻ nhỏ'),
                  disabledBorderColor: Colors.green,
                  onPressed: isAdult
                      ? () {
                          setState(() {
                            isAdult = !isAdult;
                            print(isAdult);
                          });
                        }
                      : null,
                ),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.keyboard_arrow_down),
                        onPressed: qtt > 1
                            ? () {
                                setState(() {
                                  qtt--;
                                });
                              }
                            : null),
                    Text(qtt.toString()),
                    IconButton(
                        icon: Icon(Icons.keyboard_arrow_up),
                        onPressed: () {
                          setState(() {
                            qtt++;
                          });
                        })
                  ],
                ),
              ],
            ),
          ),
          Text(
            'Mô Tả',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\tNha Trang với khí hậu ôn hòa, biển xanh trong quanh năm cùng những điểm vui chơi bậc nhất và không ngừng đổi mới hằng ngày luôn thu hút du khách gần xa. Đến với Nha Trang, du khách không chỉ tận hưởng những đợt gió biển trong nắng ấm mà còn có dịp thưởng thức hải sản tươi ngon cùng sự chào đón nồng hậu từ những người dân vùng biển nghĩa tình, cho Quý khách trải nghiệm khó quên tại vùng đất này.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              color: Colors.black,
            ),
          ),
          Text(
            'Lịch trình',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          buildActivities(tour.activities),
        ],
      ),
    );
  }

  Widget buildActivities(List<Activities> a) {
    List<Widget> list = new List<Widget>();
    a.forEach((element) {
      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: TimelineTile(
            alignment: TimelineAlign.left,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 60,
              padding: const EdgeInsets.all(8),
              indicator: Text(element.num),
            ),
            rightChild: Text(activityString(element.desc))),
      ));
      list.add(Divider(
        color: Colors.black,
      ));
    });
    return new Column(children: list);
  }

  String activityString(String string) {
    return string
        .replaceAll("\n                                           ", "")
        .replaceAll(
            "\n                                        \n                                            \n\t\n\t\t\n\t\n\t\n\t\t\n\t\t\t\n\t\t\t",
            "")
        .replaceAll(
            "\n\t\t\n\t\n\n\n                                        \n                                        \n                                            \n                                                   \n                                            \n                                            \n                                                   \n                                            \n                                        \n                                        \n                                    ",
            "\n")
        .replaceAll(
            "\n                                        \n                                            \n\t\n\t\t\n\t\n\t\n\t\t\n\t\t",
            "\n")
        .replaceAll(
            "\n\t\n\n\n                                        \n                                        \n                                            \n                                                   \n                                            \n                                            \n                                                   \n                                            \n                                        \n                                        \n                                    ",
            "");
  }

  showCupertinoSheet(BuildContext context, String title, String msg) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(title),
        message: Text(msg),
        cancelButton: CupertinoActionSheetAction(
          child: Text('Bỏ qua', style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('Đăng nhập'),
            onPressed: () {
              Navigator.of(context).pop();
              // PushPages().pushToLoginPage(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ],
      ),
    );
  }
}
