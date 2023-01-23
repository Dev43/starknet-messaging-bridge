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
    uint256 public tokenCounter;
    IStarknetCore starknetCore;
    uint256 private CLAIM_SELECTOR;
    uint256 private EvaluatorContractAddress;

    constructor(address starknetCore_, uint256 eval_address) public {
        starknetCore = IStarknetCore(starknetCore_);
        EvaluatorContractAddress = eval_address;
    }

    function setstarknetCore(address starknetCore_) external {
        starknetCore = IStarknetCore(starknetCore_);
    }

    function setClaimSelector(uint256 _claimSelector) external {
        CLAIM_SELECTOR = _claimSelector;
    }

    function setEvaluatorContractAddress(uint256 _evaluatorContractAddress)
        external
    {
        EvaluatorContractAddress = _evaluatorContractAddress;
    }

    // L2 evaluator = 0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99 or 2526149038677515265213650328426051013974292914551952046681512871525993794969

    // Core contract proxy 0xde29d060D45901Fb19ED6C6e959EB22d8626708e

    function sendMessageToL2(uint256 l2_user) public {
        uint256 selector;

        // Consume the message from the StarkNet core contract.
        // This will revert the (Ethereum) transaction if the message does not exist.

        selector = uint256(
            897827374043036985111827446442422621836496526085876968148369565281492581228
        );

        uint256[] memory sender_payload = new uint256[](1);
        sender_payload[0] = l2_user;

        // Send the message to the StarkNet core contract.
        starknetCore.sendMessageToL2(
            EvaluatorContractAddress,
            selector,
            sender_payload
        );
    }
}

// Deployed at 0x58167267edBF2fa78C1cc1D1EC38740d40182900
