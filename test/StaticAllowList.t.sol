// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/examples/StaticAllowList.sol";

contract StaticAllowListTest is Test {
    StaticAllowList staticAllowList;
    address[] allowList;
    address charlie = makeAddr("charlie");
    address drop = makeAddr("drop");

    function setUp() public {
        allowList.push(makeAddr("alice"));
        allowList.push(makeAddr("bob"));

        staticAllowList = new StaticAllowList(allowList);
    }

    function testCheck() public {
        assertTrue(staticAllowList.check(allowList[0], drop));
        assertTrue(staticAllowList.check(allowList[1], drop));

        assertFalse(staticAllowList.check(charlie, drop));
    }
}
