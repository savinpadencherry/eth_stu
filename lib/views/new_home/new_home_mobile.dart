part of new_home_view;

class _NewHomeMobile extends StatefulWidget {
  const _NewHomeMobile();

  @override
  State<_NewHomeMobile> createState() => _NewHomeMobileState();
}

class _NewHomeMobileState extends State<_NewHomeMobile> with LogMixin {
  bool data = false;
  double myAmount = 0;
  late Client httpClient;
  late Web3Client web3client;
  final ethkey = '0x61D0efC4cF959d597191D20ad97ea82D6979E3E6';
  var myData;

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    web3client = Web3Client(
        'https://sepolia.infura.io/v3/4e0151b598d944d8a7f2b3933db66d97',
        httpClient);
    getBalance();
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi.json');
    String contractAddress = '0xcb6Cc503D477Ed8CC2C81706E6D4E5a7A08af40E';

    final contract = DeployedContract(
      ContractAbi.fromJson(abi, "Coins"),
      EthereumAddress.fromHex(contractAddress),
    );
    warningLog('$contract');
    return contract;
  }

  Future<List<dynamic>> queryMake(
      String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await web3client.call(
        contract: contract, function: ethFunction, params: args);
    warningLog('$result');
    return result;
  }

  getBalance() async {
    // EthereumAddress address = EthereumAddress.fromHex(ethkey);
    List<dynamic> result = await queryMake("getBalance", []);
    myData = result[0];
    data = true;
    setState(() {});
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey cred = EthPrivateKey.fromHex(
        "bf40ebdf916c6a6da3da2162bef933b6c8cc932c5d8861433c7d429611d20b97");
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    warningLog('Done till ethfunction');
    final result = await web3client.sendTransaction(
      cred,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true,
    );
    warningLog('what rsult?$result');
    return result;
  }

  Future<String> sendCoin() async {
    var bigAmount = BigInt.from(myAmount);

    var response = await submit("depositBalance", [bigAmount]);
    warningLog('Desposited$response');
    return response;
  }

  Future<String> withDrawCoin() async {
    var bigAmount = BigInt.from(myAmount);

    var response = await submit("withDrawBalance", [bigAmount]);
    warningLog('WithDrawn$response');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray300,
      body: RefreshIndicator(
        onRefresh: () => getBalance(),
        child: ListView(
          children: [
            ZStack(
              [
                VxBox()
                    .red600
                    .size(context.screenWidth, context.percentHeight * 30)
                    .make(),
                VStack([
                  (context.percentHeight * 10).heightBox,
                  "Coins".text.xl4.white.bold.center.makeCentered(),
                  (context.percentHeight * 5).heightBox,
                  VxBox(
                    child: VStack(
                      [
                        "Balance".text.gray700.bold.xl2.makeCentered(),
                        10.heightBox,
                        data
                            ? "$myData".text.bold.xl6.makeCentered()
                            : const CircularProgressIndicator().centered()
                      ],
                    ),
                  )
                      .p16
                      .white
                      .size(context.screenWidth, context.percentHeight * 18)
                      .rounded
                      .shadowXl
                      .make()
                      .p16(),
                  30.heightBox,
                  Slider.adaptive(
                      value: myAmount,
                      max: 10,
                      divisions: 10,
                      label: myAmount.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          warningLog('$value');
                          myAmount = value;
                        });
                      }),
                  HStack(
                    [
                      ElevatedButton(
                        onPressed: sendCoin,
                        child: const Text('Deposit'),
                      ).p16(),
                      150.widthBox,
                      ElevatedButton(
                        onPressed: withDrawCoin,
                        child: const Text('WithDraw'),
                      ).p16()
                    ],
                    alignment: MainAxisAlignment.end,
                    axisSize: MainAxisSize.min,
                  )
                ])
              ],
            ),
          ],
        ),
      ),
    );
  }
}
