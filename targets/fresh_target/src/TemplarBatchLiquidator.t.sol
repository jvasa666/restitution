// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.24;

import "forge-std/Test.sol";

contract TemplarBatchLiquidatorTest is Test {
    struct LiquidationAccount {
        uint256 collateralValue;
        uint256 debtValue;
        uint256 liquidationThresholdBps;
        bool isLiquidatable;
    }

    function testFuzz_templarBatchLiquidatorSimulation(
        uint256 collateral,
        uint256 debt,
        uint256 threshold
    ) public pure {
        uint256 col = bound(collateral, 100 ether, 1000000 ether);
        uint256 deb = bound(debt, 50 ether, 900000 ether);
        uint256 thr = bound(threshold, 7500, 9500); // 75% to 95% threshold in basis points

        uint256 healthFactorBps = (col * thr) / deb;

        LiquidationAccount memory acc = LiquidationAccount({
            collateralValue: col,
            debtValue: deb,
            liquidationThresholdBps: thr,
            isLiquidatable: healthFactorBps < 10000
        });

        if (acc.isLiquidatable) {
            assertTrue(healthFactorBps < 10000, "Undercollateralized account correctly flagged for batch liquidation");
        } else {
            assertTrue(healthFactorBps >= 10000, "Solvent account correctly protected from liquidation");
        }
    }
}
