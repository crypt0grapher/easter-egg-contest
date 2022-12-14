// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract EasterEggContest {
    string public constant easterEggReward =  "City Pass Whitelist spot";
    uint256 public constant easterEggWhitelistSpotMaxAllocation = 200;

    mapping(address => bool) public whitelist;
    uint256 public whitelistedCounter;

    /// @notice Mystery role owners
    mapping(address => bool) public mysteryRole;

    /// @notice Master Key
    string private constant MasterKey1 = CENSORED;
    string private constant MasterKey2 = CENSORED;
    string private constant MasterKey3 = CENSORED;
    string private constant MasterKey4 = CENSORED;

    /// @notice  Mystery Key
    string private constant MysteryKey = CENSORED;

    /// @notice This is the main and only function to interact with the smart contract
    /// @param _user The user address, not necessarily the caller
    /// @param _inputData either master key, mystery key, or HINTS
    function message(address _user, string calldata _inputData) public
    {
        if (_inputData == "HINTS") {
            // Hints given, probably with revert('hint text') to avoid gas cost
            revert("you'll get a hint");
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
