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

    /// @notice hashed Master Key
    bytes32 private hashedMasterKey;

    /// @notice hashed Mystery Key
    bytes32 private hashedMysteryKey;

    /// @notice This is the constructor called on the contract deployment, it initialized smart contract variables
    /// @param _hashedMasterKey The hashed master key, we can't store the plain master key in the contract for security reasons, so only its hash is stored
    /// @param _hashedMysteryKey Hashed mystery key
    /// @dev this is how the hashed master key is formed before passing to the constructor
    /// KEY 1 = CENSORED
    /// KEY 2 = CENSORED
    /// KEY 3 = CENSORED
    /// KEY 4 = CENSORED
    /// hashedMasterKey = keccak256(abi.encodePacked(KEY 1, KEY 2, KEY 3, KEY 4));
    constructor(bytes32 _hashedMasterKey, bytes32 _hashedMysteryKey) {
        easterEggContestActivated = true;
        easterEggReward = "City Pass Whitelist spot";
        easterEggWhitelistSpotMaxAllocation = 200;
        hashedMasterKey = _hashedMasterKey;
        hashedMysteryKey = _hashedMysteryKey;
    }

    /// @notice This is the main and only function to interact with the smart contract
    /// @param _user The user address, not necessarily the caller
    /// @param _inputData either master key, mystery key, or HINTS
    function message(address _user, string calldata _inputData) public
    {
        require(easterEggContestActivated, "EasterEggContest: Easter Egg Contest should be activated");
        if (keccak256(abi.encodePacked(_inputData)) == keccak256("HINTS")) {
            // Hints given, probably with revert('hint text') to avoid gas cost
            revert("this is a hint");
        } else if (keccak256(abi.encodePacked(_inputData)) == hashedMasterKey) {
            if (whitelistedCounter < easterEggWhitelistSpotMaxAllocation) {
                whitelist[_user] = true;
                whitelistedCounter++;
            } else {
                revert("Max allocation reached");
            }
        } else if (keccak256(abi.encodePacked(_inputData)) == hashedMysteryKey) {
            mysteryRole[_user] = true;
        } else {
            revert("Wrong key");
        }
    }
}
