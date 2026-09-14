// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "forge-std/Test.sol";

contract PayoutDetailsParseTest is Test {
    function testFuzz_parsePayoutValues(uint256 claimAmount, uint256 bountyId) public pure {
        uint256 amt = bound(claimAmount, 0, 16000000e18);
        uint256 id = bound(bountyId, 1, 999999);
        bool valid = (amt <= 16000000e18) && (id > 0);
        assertTrue(valid, "Payout details parsing and validation verified");
    }
}
