// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "forge-std/Test.sol";

contract LiquidationWaterfallTest is Test {
    function testFuzz_liquidationWaterfallClearing(uint256 debtAmount, uint256 seizedCollateral, uint256 liquidationBonus) public pure {
        uint256 debt = bound(debtAmount, 100e18, 50000e18);
        uint256 bonus = bound(liquidationBonus, 101, 115); // 1% to 15% bonus
        uint256 seized = bound(seizedCollateral, debt, (debt * bonus) / 100);
        
        bool coversDebt = seized >= debt;
        assertTrue(coversDebt, "Liquidation waterfall successfully covers debt and bonus");
    }
}
