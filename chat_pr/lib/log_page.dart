import 'package:chat_pr/database/drift_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:chat_pr/log_to_map.dart';

class Para {
  final String name_para;
  final String addr_para;
  final double lat_para;
  final double lng_para;
  final int idx;
  Para(this.name_para, this.addr_para, this.lat_para, this.lng_para, this.idx);
}

class logPage extends StatefulWidget {
  @override
  State<logPage> createState() => _SearchlogState();
}

class _SearchlogState extends State<logPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff00b050),
        title: Center(
          child: Image.asset(
            'asset/img/chat_logo.png',
            fit: BoxFit.contain,
            height: 50,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Color(0xff00b050),
      body: Column(
        children: [
          _titlebar(),
          Expanded(
            child: Container(
              color: Color(0xffeeeeee),
              child: StreamBuilder<List<HistoryData>>(
                  stream: GetIt.I<LocalDatabase>().watchHistory(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          '검색 기록이 없습니다!',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }
                    if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          '검색 기록이 없습니다!',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }
                    return ListView.separated(
                        padding: const EdgeInsets.all(10.0),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8.0);
                        },
                        itemCount: snapshot.data!.length, //검색 기록 개수 수정 요망
                        itemBuilder: (context, int index) {
                          final histories = snapshot.data![index];

                          final para = Para(
                              histories.Hospital_name,
                              histories.Hospital_addr,
                              histories.lat,
                              histories.lng,
                              index);
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      logMap(parameter: para)));
                              //검색했던 병원 지도가서 보기;
                            },
                            child: Dismissible(
                              key: ObjectKey(histories),
                              direction: DismissDirection.endToStart,
                              onDismissed: (DismissDirection direction) {
                                GetIt.I<LocalDatabase>()
                                    .deleteHistory(histories);
                              },
                              background: Container(
                                margin: const EdgeInsets.all(8),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.green,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'asset/img/logo.png',
                                  fit: BoxFit.contain,
                                  height: 20,
                                ),
                              ),
                              secondaryBackground: Container(
                                decoration: ShapeDecoration(
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                ),
                                margin: const EdgeInsets.all(8),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.centerRight,
                                child: const Icon(
                                  Icons.delete,
                                  size: 36,
                                  color: Colors.white,
                                ),
                              ),
                              dismissThresholds: {
                                DismissDirection.endToStart: 0.5,
                              },
                              child: Container(
                                decoration: _Log_Decoration(),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "${histories.searchWord} | ${histories.Hospital_name}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(histories.Hospital_addr),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titlebar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SizedBox(
        height: 35,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: Text(
            "최근 탐색 기록",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _Log_Decoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        width: 1.0,
        color: Colors.green,
      ),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
