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

## Applications

See [src/examples/StaticAllowList.sol](https://github.com/showtime-xyz/drop-bouncers/blob/main/src/examples/StaticAllowList.sol) for a good starting point. It lets you do a Merkle-style drop (a static list of addresses that are allowed to mint):

```solidity
import {IDropEligibilityChecker} from "../interfaces/IDropEligibilityChecker.sol";

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
```

Some differences:

- the list of addresses doesn't have to be static (in fact, see [src/examples/DynamicAllowList.sol](https://github.com/showtime-xyz/drop-bouncers/blob/main/src/examples/DynamicAllowList.sol) 😇)
- the storage cost must be paid by the deployer upfront, but it can be reused across drops
- unlike a merkle drop, it doesn't require any off-chain computation
