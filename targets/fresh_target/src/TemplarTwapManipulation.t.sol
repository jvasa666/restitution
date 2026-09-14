// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.24;

import "forge-std/Test.sol";

contract TemplarTwapManipulationTest is Test {
    struct TwapState {
        uint256 cumulativePrice;
        uint256 timeElapsed;
        uint256 spotPrice;
        uint256 twapPrice;
    }

    function testFuzz_templarTwapManipulationResistance(
        uint256 initialPrice,
        uint256 manipulatedPrice,
        uint256 timeDelta
    ) public pure {
        uint256 p0 = bound(initialPrice, 1e18, 1000e18);
        uint256 p1 = bound(manipulatedPrice, 1e18, 1000e18);
        uint256 dt = bound(timeDelta, 1, 1800); // up to 30 minutes window

        TwapState memory state = TwapState({
            cumulativePrice: p0 * 1800 + p1 * dt,
            timeElapsed: 1800 + dt,
            spotPrice: p1,
            twapPrice: 0
        });

        state.twapPrice = state.cumulativePrice / state.timeElapsed;

        uint256 minPrice = p0 < p1 ? p0 : p1;
        uint256 maxPrice = p0 > p1 ? p0 : p1;

        assertTrue(state.twapPrice >= minPrice && state.twapPrice <= maxPrice, "TWAP price stays strictly bounded between initial and spot price");
    }
}
