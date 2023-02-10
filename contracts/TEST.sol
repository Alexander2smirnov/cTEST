// SPDX-License-Identifier: GPL-3.0
 
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/** 
 * @title TEST token
 * @dev token for testing
 */
contract TEST is ERC20 {
    constructor() ERC20('TEST', 'TEST') {
    }

    function mint(address _account, uint256 _amount) public {
        _mint(_account, _amount);
    }
}