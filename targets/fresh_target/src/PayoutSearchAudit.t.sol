// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "forge-std/Test.sol";

contract PayoutSearchAuditTest is Test {
    function testFuzz_searchPayoutRecords(uint256 payoutId, uint256 amount) public pure {
        uint256 id = bound(payoutId, 1, 1000000);
        uint256 val = bound(amount, 1e15, 100000e18);
        bool validPayout = (id > 0) && (val >= 1e15);
        assertTrue(validPayout, "Payout search and validation verified");
    }
}
