pragma solidity ^0.8.0;
pragma abicoder v2;

// SPDX-License-Identifier: GPL-3.0-only

import "./forwarder/IForwarder.sol";
import "./abstract/BasePaymaster.sol";

contract TestPaymasterEverythingAccepted is BasePaymaster {
    function versionPaymaster()
        external
        view
        virtual
        override
        returns (string memory)
    {
        return "3.0.0-beta.3+opengsn.test-pea.ipaymaster";
    }

    event SampleRecipientPreCall();
    event SampleRecipientPostCall(bool success, uint256 actualCharge);

    // solhint-disable-next-line no-empty-blocks
    function _verifyValue(
        GsnTypes.RelayRequest calldata
    ) internal view override {}

    function _preRelayedCall(
        GsnTypes.RelayRequest calldata relayRequest,
        bytes calldata signature,
        bytes calldata approvalData,
        uint256 maxPossibleGas
    ) internal virtual override returns (bytes memory, bool) {
        (relayRequest, signature);
        (approvalData, maxPossibleGas);
        emit SampleRecipientPreCall();
        return ("no revert here", false);
    }

    function _postRelayedCall(
        bytes calldata context,
        bool success,
        uint256 gasUseWithoutPost,
        GsnTypes.RelayData calldata relayData
    ) internal virtual override {
        (context, gasUseWithoutPost, relayData);
        emit SampleRecipientPostCall(success, gasUseWithoutPost);
    }

    function deposit() public payable {
        require(address(relayHub) != address(0), "relay hub address not set");
        relayHub.depositFor{value: msg.value}(address(this));
    }

    function withdrawAll(address payable destination) public {
        uint256 amount = relayHub.balanceOf(address(this));
        withdrawRelayHubDepositTo(amount, destination);
    }
}
