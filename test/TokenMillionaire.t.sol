// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/examples/TokenMillionaire.sol";

contract MockERC20 is IERC20 {
    mapping(address => uint256) public balanceOf;
    uint8 public decimals;

    constructor(uint8 _decimals) {
        decimals = _decimals;
    }

    function mint(address recipient, uint256 amount) public {
        balanceOf[recipient] += amount;
    }
}

contract TokenMillionaireTest is Test {
    MockERC20 public basicToken;
    MockERC20 public mockUSDC;

    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    address drop = makeAddr("drop");

    function setUp() public {
        basicToken = new MockERC20(uint8(18));
        mockUSDC = new MockERC20(uint8(6));
    }

    function testCheckWithBasicToken(uint256 howManyMillions) public {
        vm.assume(howManyMillions <= 1e6);
        vm.assume(howManyMillions > 0);
        basicToken.mint(alice, howManyMillions * 1e6 * 10 ** uint256(basicToken.decimals()));
        TokenMillionaire tokenMillionaire = new TokenMillionaire(address(basicToken));

        // alice is a token millionaire
        assertTrue(tokenMillionaire.check(alice, drop));

        // bob is not
        assertFalse(tokenMillionaire.check(bob, drop));
    }

    function testCheckWithUSDC(uint256 howManyMillions) public {
        vm.assume(howManyMillions <= 1e6);
        vm.assume(howManyMillions > 0);
        mockUSDC.mint(alice, howManyMillions * 1e6 * 10 ** uint256(mockUSDC.decimals()));
        TokenMillionaire tokenMillionaire = new TokenMillionaire(address(mockUSDC));

        // alice is a millionaire
        assertTrue(tokenMillionaire.check(alice, drop));

        // bob is not
        assertFalse(tokenMillionaire.check(bob, drop));
    }
}