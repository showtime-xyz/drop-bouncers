// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {NobodyEligible} from "../src/examples/NobodyEligible.sol";

contract NobodyEligibleDeploy is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        console2.log("Deploying from", vm.addr(deployerPrivateKey));
        NobodyEligible newContract = new NobodyEligible();
        console2.log("Deployed to", address(newContract));
    }
}
