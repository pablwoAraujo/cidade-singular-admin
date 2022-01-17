import 'package:cidade_singular_admin/app/services/place_service.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';

class AddressSearch extends SearchDelegate<Suggestion?> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  String sessionToken;
  late PlaceApiProvider apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      CloseButton(
        color: Constants.primaryColor,
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton(
      color: Constants.primaryColor,
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Suggestion>>(
      future: query == "" ? null : apiClient.fetchSuggestions(query, "pt_BR"),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Digite o endereço'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text((snapshot.data?.elementAt(index) as Suggestion)
                        .description),
                    onTap: () async {
                      Suggestion place =
                          snapshot.data?.elementAt(index) as Suggestion;
                      place = await apiClient.getPlaceDetail(place);
                      close(context,
                          snapshot.data?.elementAt(index) as Suggestion);
                    },
                  ),
                  itemCount: snapshot.data?.length,
                )
              : Text('Carregando...'),
    );
  }
}
