// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IDropEligibilityChecker {
	function check(address recipient, address drop) external view returns (bool);
}
