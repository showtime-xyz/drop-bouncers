// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IDropEligibilityChecker} from "../interfaces/IDropEligibilityChecker.sol";

contract NobodyEligible is IDropEligibilityChecker {
    function check(address /* recipient */, address /* drop */) external pure override returns (bool) {
        return false;
    }
}
