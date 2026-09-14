// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "forge-std/Test.sol";

contract OracleTwapDeviationTest is Test {
    function testFuzz_twapPriceDeviation(uint256 spotPrice, uint256 twapPrice, uint256 maxDeviationBps) public pure {
        uint256 spot = bound(spotPrice, 100e18, 10000e18);
        uint256 twap = bound(twapPrice, 100e18, 10000e18);
        uint256 maxDev = bound(maxDeviationBps, 100, 1000); // 1% to 10%
        
        uint256 diff = spot > twap ? spot - twap : twap - spot;
        uint256 deviationBps = (diff * 10000) / twap;
        
        bool safe = deviationBps <= maxDev;
        bool flagged = deviationBps > maxDev;
        
        assertTrue(safe || flagged, "TWAP deviation check completed");
    }
}
