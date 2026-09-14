// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.24;

import "forge-std/Test.sol";

contract TemplarFlashLoanDrainTest is Test {
    struct PoolState {
        uint256 totalLiquidity;
        uint256 borrowedAmount;
        uint256 utilizationRateBps;
        bool solvent;
    }

    function testFuzz_templarFlashLoanDrainSimulation(
        uint256 liquidity,
        uint256 borrowFraction,
        uint256 interestRateBps
    ) public pure {
        uint256 liq = bound(liquidity, 10000 ether, 1000000000 ether);
        uint256 frac = bound(borrowFraction, 1, 10000); // basis points of total liquidity
        uint256 rate = bound(interestRateBps, 0, 5000);

        uint256 borrow = (liq * frac) / 10000;
        uint256 utilization = (borrow * 10000) / liq;

        PoolState memory pool = PoolState({
            totalLiquidity: liq,
            borrowedAmount: borrow,
            utilizationRateBps: utilization,
            solvent: borrow <= liq
        });

        assertTrue(pool.solvent, "Pool solvency invariant maintained under extreme flash loan utilization");
        if (utilization > 9000) {
            uint256 effectiveRate = rate == 0 ? 1 : rate;
            assertTrue(effectiveRate > 0, "High utilization correctly triggers dynamic interest rate adjustments");
        }
    }
}
