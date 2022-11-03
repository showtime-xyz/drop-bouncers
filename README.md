## Showtime Drops Contract Based Eligibility

Showtime now supports eligibility checks based on 3rd party contracts.

In a nutshell, you need to deploy a contract that implements the [src/interfaces/IDropEligibilityChecker.sol](https://github.com/showtime-xyz/drop-bouncers/blob/main/src/interfaces/IDropEligibilityChecker.sol) interface:

```solidity
interface IDropEligibilityChecker {
	function check(address recipient, address drop) external view returns (bool);
}
```

The `check` function should return `true` if the recipient is eligible for the drop, and `false` otherwise.

See this [page](https://showtime-xyz.notion.site/Drops-With-Contract-Conditions-Public-2dea4ac2829046579a9b2f7ec6721ffc) for more details and the API integration.
