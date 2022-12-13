// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/EasterEggContest.sol";

contract EasterEggContestTest is Test {
    EasterEggContest public easterEgg;

    string constant private MASTER_KEY1 = "censoredKey1";
    string constant private MASTER_KEY2 = "censoredKey2";
    string constant private MASTER_KEY3 = "censoredKey3";
    string constant private MASTER_KEY4 = "censoredKey4";
    string constant private MYSTERY_KEY = "censoredMysteryKey";

    function setUp() public {
        bytes32 hashedMasterKey = keccak256(abi.encodePacked(MASTER_KEY1, MASTER_KEY2, MASTER_KEY3, MASTER_KEY4));
        bytes32 doubleHashedMasterKey = keccak256(abi.encode(hashedMasterKey));

        bytes32 hashedMysteryKey = keccak256(abi.encodePacked(MYSTERY_KEY));
        bytes32 doubleHashedMysteryKey = keccak256(abi.encode(hashedMysteryKey));

        easterEgg = new EasterEggContest(doubleHashedMasterKey, doubleHashedMysteryKey);
    }

    function testWhiteList() public {
        address testUser = address(0x1234);
        easterEgg.message(testUser, string(abi.encodePacked(keccak256(abi.encodePacked(MASTER_KEY1, MASTER_KEY2, MASTER_KEY3, MASTER_KEY4)))));
        assertEq(easterEgg.whitelist(testUser), true);
    }

    function testWrongMasterKey() public {
        address testUser = address(0x1234);
        vm.expectRevert(abi.encodePacked("Wrong key"));
        easterEgg.message(testUser, string(abi.encodePacked(keccak256(abi.encodePacked("some wrong key")))));
    }

    function testHint() public {
        address testUser = address(0x1234);
        vm.expectRevert(abi.encodePacked("this is a hint"));
        easterEgg.message(testUser, "HINTS");
    }

    function testMysteryKey() public {
        address testUser = address(0x1234);
        easterEgg.message(testUser, string(abi.encodePacked(keccak256(abi.encodePacked(MYSTERY_KEY)))));
        assertEq(easterEgg.mysteryRole(testUser), true);
    }

}
