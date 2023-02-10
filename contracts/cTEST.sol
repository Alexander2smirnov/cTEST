// SPDX-License-Identifier: GPL-3.0
 
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
 
/** 
 * @title cTEST compound-like smart contract
 */
contract cTEST is ERC20 {
    uint public totalUnderlying;
    uint public scale = 10**18;
    uint public exchangeRate = 10**28;
    address public underlyingToken;

    constructor(address _token) ERC20("cTEST", "cTEST") {
        underlyingToken = _token;
    }

    function addUnderlying(uint _amount) public {
        totalUnderlying += _amount;
    }

    function mint(uint256 _amount) public returns (uint256) {
        IERC20 token = IERC20(underlyingToken);

        token.transferFrom(msg.sender, address(this), _amount);

        uint cTokenAmount = _amount * scale / exchangeRate;

        _mint(msg.sender, cTokenAmount);

    }

    function exchangeRateCurrent() public view returns (uint256) {
        return exchangeRate;
    }

    function changeExchangeRate(uint _diff) public {
        exchangeRate += _diff;
    }

    function redeemUnderlying(uint _amount) public returns (uint) {
        IERC20 token = IERC20(underlyingToken);

        uint cTokenAmount = _amount * scale / exchangeRate;

        _burn(msg.sender, cTokenAmount);

        token.transfer(msg.sender, _amount);
    }

    function balanceOfUnderlying(address _account) public view returns (uint) {
        uint cTokenBalance = balanceOf(_account);

        return cTokenBalance * exchangeRate / scale;
    }

    function decimals() public view override returns (uint8) {
        return 8;
    }
    
}