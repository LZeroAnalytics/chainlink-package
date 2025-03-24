ethereum = import_module("github.com/LZeroAnalytics/ethereum-package@dev/main.star")
constants = import_module("./src/package_io/constants.star")

def run(plan, args):
    price_feeds = {}
    if args["network_params"]["network_type"] == "ethereum":
         price_feeds = constants.ETHEREUM_PRICE_FEEDS
    elif args["network_params"]["network_type"] == "arbitrum":
        price_feeds = constants.ARBITRUM_PRICE_FEEDS
    elif args["network_params"]["network_type"] == "optimism":
        price_feeds = constants.OP_PRICE_FEEDS
    elif args["network_params"]["network_type"] == "base":
        price_feeds = constants.BASE_PRICE_FEEDS
    elif args["network_params"]["network_type"] == "linea":
        price_feeds = constants.LINEA_PRICE_FEEDS
    else:
        fail("Specified network type not supported")

    for participant in args["participants"]:
         participant["el_image"] = "tiljordan/reth-chainlink:1.0.0"
         participant["el_type"] = "reth"
         participant["el_extra_env_vars"]["PRICE_FEEDS"] = json.encode(price_feeds)

    ethereum.run(plan, args)