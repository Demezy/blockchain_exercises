// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract DemezyToken is ERC20{
    constructor(uint256 total) ERC20("n.gurniak", "NIKITA") {  
	totalSupply_ = total * 10 ** 18;
	balances[msg.sender] = totalSupply_;
    }  


    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;
    
    uint256 totalSupply_;
    uint256 feeAmount_ = 50;
    address feeAddress_ = 0xD8C7978Be2A06F5752cB727fB3B7831B70bF394d;

    using SafeMath for uint256;

    function totalSupply() public view override returns (uint256){
        return totalSupply_;
    }

  function balanceOf(address tokenOwner) public view  override returns (uint) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) public override returns (bool) {
        require(numTokens.add(feeAmount_) <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        balances[msg.sender] = balances[msg.sender].sub(feeAmount_);
        balances[feeAddress_] = balances[feeAddress_].add(feeAmount_);
        emit Transfer(msg.sender, feeAddress_, feeAmount_);
        return true;
    }

    function approve(address delegate, uint numTokens) public override  returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public view override returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint numTokens) public override returns (bool) {
        require(numTokens <= balances[owner]);    
        require(numTokens <= allowed[owner][msg.sender]);
    
        balances[owner] = balances[owner].sub(numTokens);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}

library SafeMath { 
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
      assert(b <= a);
      return a - b;
    }
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
      uint256 c = a + b;
      assert(c >= a);
      return c;
    }
}