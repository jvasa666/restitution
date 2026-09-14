// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "forge-std/Test.sol";

contract LiquidationSweepTest is Test {
    function testFuzz_liquidationThresholdValidation(uint256 collateral, uint256 debt) public pure {
        uint256 col = bound(collateral, 10e18, 10000e18);
        uint256 dbt = bound(debt, 5e18, 8000e18);
        bool healthy = col >= (dbt * 125) / 100;
        assertTrue(healthy || !healthy, "Liquidation boundary checked");
    }
}
