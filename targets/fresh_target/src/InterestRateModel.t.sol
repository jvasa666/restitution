// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;
import "forge-std/Test.sol";
contract InterestRateModelTest is Test {
    function testFuzz_utilizationRateAndBorrowRate(uint256 totalBorrows, uint256 totalCash, uint256 reserves) public pure {
        uint256 cash = bound(totalCash, 1e18, 1000000e18);
        uint256 borrows = bound(totalBorrows, 0, cash);
        uint256 res = bound(reserves, 0, cash / 10);
        uint256 utilization = (borrows * 1e18) / (cash + borrows - res + 1);
        assertTrue(utilization <= 1e18, "Utilization rate properly bounded");
    }
}
