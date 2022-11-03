// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IDropEligibilityChecker} from "../interfaces/IDropEligibilityChecker.sol";

/// Allows anyone who claimed from one of N previous drops
contract PreviousDropCollector is IDropEligibilityChecker {
    address[] previousDrops;

    constructor(address[] memory _previousDrops) {
        uint256 length = _previousDrops.length;
        for (uint256 i = 0; i < length; ) {
            previousDrops.push(_previousDrops[i]);

            unchecked {
                i++;
            }
        }
    }

    function check(address recipient, address /* drop */) external view override returns (bool) {
        // TODO
        return true;
    }
}
