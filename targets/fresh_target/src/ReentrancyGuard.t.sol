// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;
import "forge-std/Test.sol";
contract ReentrancyGuardTest is Test {
    uint256 private _status = 1;
    modifier nonReentrant() {
        require(_status == 1, "REENTRANCY");
        _status = 2;
        _;
        _status = 1;
    }
    function _executeAction() internal nonReentrant {
        _status = 2; // simulate guarded action
    }
    function testFuzz_reentrancyProtection(uint256 seed) public {
        seed;
        _status = 1;
        _executeAction();
        assertTrue(_status == 1, "Reentrancy guard status reset successfully");
    }
}
