// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IDropEligibilityChecker} from "../interfaces/IDropEligibilityChecker.sol";

interface IERC721 {
    function balanceOf(address account) external view returns (uint256);
}

contract NoBAYC is IDropEligibilityChecker {
    IERC721 constant BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);

    function check(address recipient, address /* drop */) external view override returns (bool) {
        return BAYC.balanceOf(recipient) == 0;
    }
}