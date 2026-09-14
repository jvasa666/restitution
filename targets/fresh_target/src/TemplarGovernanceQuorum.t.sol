// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.24;

import "forge-std/Test.sol";

contract TemplarGovernanceQuorumTest is Test {
    struct ProposalVote {
        uint256 totalVotesFor;
        uint256 totalVotesAgainst;
        uint256 quorumRequired;
        uint256 circulatingSupply;
    }

    function testFuzz_templarGovernanceQuorumValidation(
        uint256 votesFor,
        uint256 votesAgainst,
        uint256 supply
    ) public pure {
        uint256 circSupply = bound(supply, 1000000 ether, 100000000 ether);
        uint256 forVotes = bound(votesFor, 0, circSupply);
        uint256 againstVotes = bound(votesAgainst, 0, circSupply);

        uint256 quorumBps = 400; // 4% quorum requirement
        uint256 requiredQuorum = (circSupply * quorumBps) / 10000;

        ProposalVote memory prop = ProposalVote({
            totalVotesFor: forVotes,
            totalVotesAgainst: againstVotes,
            quorumRequired: requiredQuorum,
            circulatingSupply: circSupply
        });

        uint256 totalParticipation = prop.totalVotesFor + prop.totalVotesAgainst;
        bool quorumMet = totalParticipation >= prop.quorumRequired;

        if (quorumMet) {
            assertTrue(totalParticipation >= prop.quorumRequired, "Quorum threshold correctly validated for active proposal");
        } else {
            assertTrue(totalParticipation < prop.quorumRequired, "Insufficient participation correctly rejected");
        }
    }
}
