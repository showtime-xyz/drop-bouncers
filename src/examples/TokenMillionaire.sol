// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IDropEligibilityChecker} from "../interfaces/IDropEligibilityChecker.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function decimals() external view returns (uint8);
}

/// You're eligible if you have at least 1M $TOKEN
contract TokenMillionaire is IDropEligibilityChecker {
    IERC20 public token;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function check(address recipient, address /* drop */) external view override returns (bool) {
        return token.balanceOf(recipient) >= 1e6 * 10 ** token.decimals();
    }
}