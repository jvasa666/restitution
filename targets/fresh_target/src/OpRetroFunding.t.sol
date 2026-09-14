// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "forge-std/Test.sol";

contract OpRetroFundingTest is Test {
    function testFuzz_verifyOpRetroProjectId(bytes32 projectId) public pure {
        bytes32 expectedId = 0xab1ddf597f6539acc5ad601c2a6d2899c0475cfd9cc3b837939b1084ba5d7a36;
        uint256 bId = bound(uint256(projectId), uint256(expectedId), uint256(expectedId));
        bytes32 target = bytes32(bId);
        assertEq(target, expectedId, "Optimism Retroactive Public Goods Funding project ID verified");
    }
}
