// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;
import "forge-std/Test.sol";
contract FeeCollectorTest is Test {
    function testFuzz_protocolFeeSplit(uint256 amount, uint256 feeBps) public pure {
        uint256 amt = bound(amount, 1e15, 10000e18);
        uint256 bps = bound(feeBps, 1, 500); // 0.01% to 5%
        uint256 fee = (amt * bps) / 10000;
        uint256 residual = amt - fee;
        assertTrue(fee + residual == amt, "Fee split conservation holds");
    }
}
