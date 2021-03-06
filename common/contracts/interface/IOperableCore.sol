pragma solidity ^0.6.0;

import "./IOperableStorage.sol";


/**
 * @title IOperableCore
 * @dev The Operable contract enable the restrictions of operations to a set of operators
 *
 * @author Cyril Lapinte - <cyril.lapinte@openfiz.com>
 * SPDX-License-Identifier: MIT
 *
 * Error messages
 */
abstract contract IOperableCore is IOperableStorage {
  function defineRole(bytes32 _role, bytes4[] memory _privileges) virtual public returns (bool);
  function assignOperators(bytes32 _role, address[] memory _operators) virtual public returns (bool);
  function assignProxyOperators(
    address _proxy, bytes32 _role, address[] memory _operators) virtual public returns (bool);
  function revokeOperators(address[] memory _operators) virtual public returns (bool);
}
