// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IEdition} from "nft-editions/interfaces/IEdition.sol";

import {IDropEligibilityChecker} from "../interfaces/IDropEligibilityChecker.sol";

/// Allows anyone who claimed from one of N previous drops
contract PreviousDropCollector is IDropEligibilityChecker {
    IEdition[] previousDrops;

    constructor(address[] memory _previousDrops) {
        uint256 length = _previousDrops.length;
        require(length > 0, "EMPTY_LIST");
        for (uint256 i = 0; i < length; ) {
            previousDrops.push(IEdition(_previousDrops[i]));

            unchecked {
                i++;
            }
        }
    }

    function check(address recipient, address /* drop */) external view override returns (bool) {
        uint256 length = previousDrops.length;
        for (uint256 i = 0; i < length; ) {
            /// @dev note that this can be gamed because the same edition can be transferred from wallet to wallet
            if (previousDrops[i].balanceOf(recipient) > 0) {
                return true;
            }

            unchecked {
                i++;
            }
        }

        return false;
    }
}
