pragma solidity ^0.6.0;

import "../TokenStorage.sol";
import "../TokenProxy.sol";


/**
 * @title SeizableDelegate
 * @dev Token which allows owner to seize accounts
 *
 * @author Cyril Lapinte - <cyril.lapinte@openfiz.com>
 * SPDX-License-Identifier: MIT
 *
 * Error messages
 * ST01: Transfer events must be generated
 * ST02: Operator cannot seize itself
*/
abstract contract SeizableDelegate is TokenStorage {

  /**
   * @dev called by the owner to seize value from the account
   */
  function seize(
    address _token,
    address _account,
    uint256 _amount) public returns (bool)
  {
    require(_account != msg.sender, "ST02");
    TokenData storage token = tokens[_token];

    token.balances[_account] = token.balances[_account].sub(_amount);
    token.balances[msg.sender] = token.balances[msg.sender].add(_amount);
    token.allTimeSeized = token.allTimeSeized.add(_amount);

    require(
      TokenProxy(_token).emitTransfer(_account, msg.sender, _amount),
      "ST01");
    emit Seize(_token, _account, _amount);
    return true;
  }
}
