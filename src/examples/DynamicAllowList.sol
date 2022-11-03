// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Owned} from "solmate/auth/Owned.sol";

import {IDropEligibilityChecker} from "../interfaces/IDropEligibilityChecker.sol";

contract DynamicAllowList is IDropEligibilityChecker, Owned {
    mapping(address => bool) public allowList;

    constructor(address _owner) Owned(_owner) {
        // deliberately empty
    }

    function setAllowList(address[] calldata _addresses, bool _allowed) external onlyOwner {
        uint256 length = _addresses.length;
        for (uint256 i = 0; i < length;) {
            allowList[_addresses[i]] = _allowed;

            unchecked {
                i++;
            }
        }
    }

    function check(address recipient, address /* drop */) external view override returns (bool) {
        return allowList[recipient];
    }
}
