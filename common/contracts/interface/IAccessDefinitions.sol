pragma solidity ^0.6.0;


/**
 * @title IAccessDefinitions
 * @dev IAccessDefinitions
 *
 * @author Cyril Lapinte - <cyril.lapinte@openfiz.com>
 * SPDX-License-Identifier: MIT
 */
contract IAccessDefinitions {

  // Hardcoded role granting all - non sysop - privileges
  bytes32 internal constant ALL_PRIVILEGES = bytes32("AllPrivileges");
  address internal constant ALL_PROXIES = address(0x416c6C50726F78696573); // "AllProxies"

  // Roles
  bytes32 internal constant FACTORY_CORE_ROLE = bytes32("FactoryCoreRole");
  bytes32 internal constant FACTORY_PROXY_ROLE = bytes32("FactoryProxyRole");

  // Sys Privileges
  bytes4 internal constant DEFINE_ROLE_PRIV =
    bytes4(keccak256("defineRole(bytes32,bytes4[])"));
  bytes4 internal constant ASSIGN_OPERATORS_PRIV =
    bytes4(keccak256("assignOperators(bytes32,address[])"));
  bytes4 internal constant REVOKE_OPERATORS_PRIV =
    bytes4(keccak256("revokeOperators(address[])"));
  bytes4 internal constant ASSIGN_PROXY_OPERATORS_PRIV =
    bytes4(keccak256("assignProxyOperators(address,bytes32,address[])"));
}
