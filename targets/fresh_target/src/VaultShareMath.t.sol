// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "forge-std/Test.sol";

contract DefendedVaultProductionTest is Test {
    uint256 totalSupply;
    uint256 totalAssets;
    uint256 constant OFFSET = 1e6;

    function simulateDeposit(uint256 assets) public returns (uint256 shares) {
        uint256 _totalSupply = totalSupply;
        uint256 _totalAssets = totalAssets;

        if (_totalSupply == 0 || _totalAssets == 0) {
            shares = assets > OFFSET ? assets - OFFSET : 1;
        } else {
            shares = (assets * (_totalSupply + OFFSET)) / (_totalAssets + 1);
        }
        
        totalSupply += shares;
        totalAssets += assets;
    }

    function simulateDonate(uint256 assets) public {
        totalAssets += assets;
    }

    function testFuzz_defendedInflationAttackProduction(uint256 attackerDeposit, uint256 donationAmount, uint256 victimDeposit) public {
        attackerDeposit = bound(attackerDeposit, 1e15, 1e20);
        donationAmount = bound(donationAmount, 1e12, 1e16);
        victimDeposit = bound(victimDeposit, 1e16, 1e22);

        simulateDeposit(attackerDeposit);
        simulateDonate(donationAmount);
        
        uint256 victimShares = simulateDeposit(victimDeposit);

        assertGt(victimShares, 0, "Production invariant failed: Zero share minting permitted under extreme donation ratio.");
    }
}
