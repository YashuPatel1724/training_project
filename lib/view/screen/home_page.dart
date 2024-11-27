import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/movie_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<MovieProvider>(context);
    var providerFalse = Provider.of<MovieProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              providerFalse.getSearch(value);
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              label: Text('Search Movie Name'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          FutureBuilder(
            future: providerFalse.apiCalling(),
            builder: (context, snapshot) {
              if(snapshot.hasData)
                {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: providerTrue.moviesModal!.d.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 75, left: 10, right: 10),
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset:
                                    Offset(0, 5), // X and Y offset of the shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 80.0, top: 40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 65.0),
                                      child: SizedBox(
                                        width: 200,
                                        child: Text(
                                          providerTrue.moviesModal!.d[index].l,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 65.0),
                                      child: SizedBox(
                                        width: 200,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              providerTrue.moviesModal!.d[index].qid.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 13,
                                                color: Colors.black45,
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Text(
                                              "| ${providerTrue.moviesModal!.d[index].q}",
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 13,
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 15),
                              child: Container(
                                height: 200,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "${providerTrue.moviesModal!.d[index].i.imageUrl}"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              else if(snapshot.hasError)
                {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
              else
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
