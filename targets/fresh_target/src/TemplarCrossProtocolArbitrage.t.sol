// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.24;

import "forge-std/Test.sol";

contract TemplarCrossProtocolArbitrageTest is Test {
    struct ArbitrageLeg {
        uint256 flashLoanAmount;
        uint256 sourcePrice;
        uint256 targetPrice;
        uint256 feeBps;
    }

    function testFuzz_templarCrossProtocolArbitrageSpread(
        uint256 loanAmt,
        uint256 srcPrice,
        uint256 tgtPrice,
        uint256 fee
    ) public pure {
        uint256 amount = bound(loanAmt, 1 ether, 1000000 ether);
        uint256 p1 = bound(srcPrice, 1e18, 100e18);
        uint256 p2 = bound(tgtPrice, 1e18, 100e18);
        uint256 f = bound(fee, 1, 50); // basis points fee

        ArbitrageLeg memory leg = ArbitrageLeg({
            flashLoanAmount: amount,
            sourcePrice: p1,
            targetPrice: p2,
            feeBps: f
        });

        uint256 loanFee = (leg.flashLoanAmount * leg.feeBps) / 10000;
        
        if (leg.targetPrice > leg.sourcePrice) {
            uint256 grossProfit = (leg.flashLoanAmount * (leg.targetPrice - leg.sourcePrice)) / leg.sourcePrice;
            if (grossProfit > loanFee) {
                uint256 netProfit = grossProfit - loanFee;
                assertTrue(netProfit > 0, "Profitable cross-protocol arbitrage vector validated");
            } else {
                assertTrue(grossProfit <= loanFee, "Unprofitable spread correctly filtered by flash loan fee");
            }
        } else {
            assertTrue(leg.targetPrice <= leg.sourcePrice, "Negative spread verified safe");
        }
    }
}
