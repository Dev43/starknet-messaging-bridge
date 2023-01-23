// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IStarknetCore {
    /**
      Sends a message to an L2 contract.
      Returns the hash of the message.
    */
    function sendMessageToL2(
        uint256 to_address,
        uint256 selector,
        uint256[] calldata payload
    ) external returns (bytes32);

    /**
      Consumes a message that was sent from an L2 contract.
      Returns the hash of the message.
    */
    function consumeMessageFromL2(
        uint256 fromAddress,
        uint256[] calldata payload
    ) external returns (bytes32);

    function l2ToL1Messages(bytes32 msgHash) external view returns (uint256);
}

contract MessagingNft {
    IStarknetCore starknetCore;

    constructor(address starknetCore_) public {
        starknetCore = IStarknetCore(starknetCore_);
    }

    function setstarknetCore(address starknetCore_) external {
        starknetCore = IStarknetCore(starknetCore_);
    }

    // L2 evaluator = 0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99 or 2526149038677515265213650328426051013974292914551952046681512871525993794969

    // Core contract proxy 0xde29d060D45901Fb19ED6C6e959EB22d8626708e

    function consumeMessage(uint256 l2_evaluator, uint256 l2_user) public {
        uint256[] memory payload = new uint256[](1);
        payload[0] = l2_user;
        // Consume the message from the StarkNet core contract.
        // This will revert the (Ethereum) transaction if the message does not exist.
        starknetCore.consumeMessageFromL2(l2_evaluator, payload);
    }
}

// Deployed at 0x4Da1E41f50715924ec6fd14EF9bEDbD364468E5f
