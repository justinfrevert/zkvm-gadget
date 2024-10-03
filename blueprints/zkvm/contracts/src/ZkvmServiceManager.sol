// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13;

import "@eigenlayer/contracts/libraries/BytesLib.sol";
import "zkvm/IZkvmTaskManager.sol";
import "@eigenlayer-middleware/src/ServiceManagerBase.sol";

/**
 * @title Primary entrypoint for procuring services from Zkvm.
 * @author Layr Labs, Inc.
 */
contract ZkvmServiceManager is ServiceManagerBase {
    using BytesLib for bytes;

    IZkvmTaskManager
        public immutable ZkvmTaskManager;

    /// @notice when applied to a function, ensures that the function is only callable by the `registryCoordinator`.
    modifier onlyZkvmTaskManager() {
        require(
            msg.sender == address(ZkvmTaskManager),
            "onlyZkvmTaskManager: not from credible squaring task manager"
        );
        _;
    }

    constructor(
        IAVSDirectory _avsDirectory,
        IRegistryCoordinator _registryCoordinator,
        IStakeRegistry _stakeRegistry,
        IZkvmTaskManager _ZkvmTaskManager
    )
        ServiceManagerBase(
            _avsDirectory,
            _registryCoordinator,
            _stakeRegistry
        )
    {
        ZkvmTaskManager = _ZkvmTaskManager;
    }

    /// @notice Called in the event of challenge resolution, in order to forward a call to the Slasher, which 'freezes' the `operator`.
    /// @dev The Slasher contract is under active development and its interface expected to change.
    ///      We recommend writing slashing logic without integrating with the Slasher at this point in time.
    function freezeOperator(
        address operatorAddr
    ) external onlyZkvmTaskManager {
        // slasher.freezeOperator(operatorAddr);
    }
}
