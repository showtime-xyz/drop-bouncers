// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {PreviousDropCollector} from "../src/examples/PreviousDropCollector.sol";

contract PreviousDropCollectorDeploy is Script {
    address constant PREV_DROP = 0x6401154E5846f99429f0aD099952D93b76208199;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        console2.log("Deploying from", vm.addr(deployerPrivateKey));

        address[] memory drops = new address[](1);
        drops[0] = PREV_DROP;

        PreviousDropCollector newContract = new PreviousDropCollector(drops);
        console2.log("Deployed to", address(newContract));
    }
}
