// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/examples/DynamicAllowList.sol";

contract DynamicAllowListTest is Test {
    DynamicAllowList dynamicAllowList;
    address[] allowList;

    address alice = makeAddr("alice");
    address bob = makeAddr("bob");

    address drop = makeAddr("drop");

    function setUp() public {
        allowList.push(makeAddr("alice"));

        dynamicAllowList = new DynamicAllowList(address(this));
        dynamicAllowList.setAllowList(allowList, true);
    }

    function testCheck() public {
        // alice is already on the list
        assertTrue(dynamicAllowList.check(alice, drop));

        // bob is not
        assertFalse(dynamicAllowList.check(bob, drop));

        // let's add bob to the list (try that, Merkle drops!)
        allowList.push(bob);
        dynamicAllowList.setAllowList(allowList, true);
        assertTrue(dynamicAllowList.check(bob, drop));

        // let's remove alice
        address[] memory aliceNoMore = new address[](1);
        aliceNoMore[0] = alice;
        dynamicAllowList.setAllowList(aliceNoMore, false);

        assertFalse(dynamicAllowList.check(alice, drop));
    }
}