void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: LoginCheck(),)
  );
}

class LoginCheck extends StatelessWidget {

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // OR getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(
        uri: 'https://api.graph.cool/simple/v1/ciyz901en4j590185wkmexyex',
      ),
    ),
  );

  final String addStar = """
  mutation AddStar(\$starrableId: ID!) {
    addStar(input: {starrableId: \$starrableId}) {
      starrable {
        viewerHasStarred
      }
    }
  }
  """;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
          child: Mutation(
            options: MutationOptions(
                onCompleted: (dynamic resultData){
                  // print("resultData $resultData");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MainPage(client: client,)
                    )
                  );
                },
                update: (Cache cache, QueryResult result) {
                  return cache;
                },
                documentNode: gql(addStar)
            ),
            builder: (RunMutation runMutation, QueryResult result){
              return LoginPage(runMutation:runMutation);
            },
          )
      ),
    );
  }
}


class MainPage extends StatelessWidget {
  ValueNotifier<GraphQLClient> client;
  MainPage({ @required this.client})
    : assert( client != null );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MainPage"),
      ),
      body: Center(
        child: RaisedButton(
            child: Text("Move Other Page"),
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => GraphQLProvider(
                client: this.client,
                child: new OtherPage()),
              )
            );
          },
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  RunMutation runMutation;
  LoginPage({@required this.runMutation})
    : assert( runMutation != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoginPage"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Move MainPage"),
          onPressed: (){
            this.runMutation({});
          },
        ),
      ),
    );
  }
}



class OtherPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Other Page"),
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(
          '''
          query {
            allUsers {
              id
              name
            }
          }
          '''
          )
        ),
        builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.loading) return Text('Loading');
          List repositories = result.data['allUsers'];
          return ListView.builder(
            itemCount: repositories.length,
            itemBuilder: (context, index) {
              return Text(repositories[index].toString());
            });
        },
      ),
    );
  }
}
