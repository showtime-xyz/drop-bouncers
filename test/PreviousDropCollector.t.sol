// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/examples/PreviousDropCollector.sol";

contract MockDrop {
    mapping(address => uint256) public balanceOf;

    function mint(address recipient) public {
        balanceOf[recipient] += 1;
    }
}

contract PreviousDropCollectorTest is Test {
    PreviousDropCollector previousDropCollector;
    address[] drops;

    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    address charlie = makeAddr("charlie");
    address drop = makeAddr("drop");

    function setUp() public {
        drops.push(address(new MockDrop()));
        drops.push(address(new MockDrop()));

        MockDrop(drops[0]).mint(alice);
        MockDrop(drops[1]).mint(bob);

        previousDropCollector = new PreviousDropCollector(drops);
    }

    function testCheck() public {
        // alice has claimed from drop 0 so she's eligible
        assertTrue(previousDropCollector.check(alice, drop));

        // bob has claimed from drop 1 so he's eligible
        assertTrue(previousDropCollector.check(bob, drop));

        // charlie has not claimed from any drops so he's not eligible
        assertFalse(previousDropCollector.check(charlie, drop));
    }
}