// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IDropEligibilityChecker} from "../interfaces/IDropEligibilityChecker.sol";

/// Not unlike a Merkle drop, but where the list of eligible recipients is
/// hardcoded in the contract at deploy time (deployer pays for storage cost)
/// Note: The same StaticAllowList contract can be used for multiple drops
contract StaticAllowList is IDropEligibilityChecker {
    mapping(address => bool) public allowList;

    constructor(address[] memory _allowList) {
        uint256 length = _allowList.length;
        for (uint256 i = 0; i < length; ) {
            allowList[_allowList[i]] = true;

            unchecked {
                i++;
            }
        }
    }

    function check(address recipient, address /* drop */) external view override returns (bool) {
        return allowList[recipient];
    }
}
