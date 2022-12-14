// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract EasterEggContest {
    bool public easterEggContestActivated;
    string public easterEggReward;
    uint256 public easterEggWhitelistSpotMaxAllocation;

    mapping(address => bool) public whitelist;
    uint256 public whitelistedCounter;

    /// @notice Mystery role owners
    mapping(address => bool) public mysteryRole;

    /// @notice Master Key
    string private MasterKey1;
    string private MasterKey2;
    string private MasterKey3;
    string private MasterKey4;

    /// @notice  Mystery Key
    string private MysteryKey;

    /// @notice This is the constructor called on the contract deployment, it initialized smart contract variables
    /// @dev this is how the  master key is formed before passing to the constructor
    constructor() {
        easterEggContestActivated = true;
        easterEggReward = "City Pass Whitelist spot";
        easterEggWhitelistSpotMaxAllocation = 200;

        MasterKey1 = CENSORED;
        MasterKey2 = CENSORED;
        MasterKey3 = CENSORED;
        MasterKey4 = CENSORED;

        MysteryKey = CENSORED;
    }

    /// @notice This is the main and only function to interact with the smart contract
    /// @param _user The user address, not necessarily the caller
    /// @param _inputData either master key, mystery key, or HINTS
    function message(address _user, string calldata _inputData) public
    {
        require(easterEggContestActivated, "EasterEggContest: Easter Egg Contest should be activated");
        if (_inputData == "HINTS") {
            // Hints given, probably with revert('hint text') to avoid gas cost
            revert("this is a hint");
            // next we check if the input data is the master key by concatenation of Key1 + key2 + key3 + key4
        } else if (_inputData == string.concat((MasterKey1, MasterKey2, MasterKey3, MasterKey4)) {
            // now the key is correct but this works only if the max allocation is not reached
            if (whitelistedCounter < easterEggWhitelistSpotMaxAllocation) {
                whitelist[_user] = true;
                whitelistedCounter++;
            } else {
                revert("Max allocation reached");
            }
            // next, if the input data is not the HINTS and not the master key, we check if it is the mystery key
        } else if (_inputData == MysteryKey) {
            mysteryRole[_user] = true;
        } else {
            // not HINTS, not master key, not mystery key, so we revert
            revert("Wrong key");
        }
    }
}
