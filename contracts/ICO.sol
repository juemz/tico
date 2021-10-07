// SPDX-License-Identifier: MIT
//源码仅做学术用途
pragma solidity >=0.6.0 <=0.8.0;

//导入代币合约和权限验证合约
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

//ICO合约继承自ERC20,Ownable合约
contract ICO is ERC20, Ownable {

    //创建ERC20代币，并发送给合约创建者
    constructor() ERC20("XYCOIN", "MUKS") {
      _mint(msg.sender, 1000000*(10**uint256(decimals())));
    }
    
    function mint(address account, uint256 amount) public onlyOwner returns (bool sucess) {
      require(account != address(0) && amount != uint256(0), "ERC20: function mint invalid input");
      _mint(account, amount);
      return true;
    }

    //设置ERC20销毁机制
    function burn(address account, uint256 amount) public onlyOwner returns (bool success) {
      require(account != address(0) && amount != uint256(0), "ERC20: function burn invalid input");
      _burn(account, amount);
      return true;
    }

    //设置购买机制，ETH与币种兑换比例为 1ether:1000coin
    function buy() public payable returns(bool sucess) {
      require(msg.sender.balance >= msg.value && msg.value != 0 ether, "ICO: function buy invalid input");
      uint256 amount = msg.value * 1000;
      _transfer(owner(), _msgSender(), amount);
      return true;
    }

    //设置提款机制，合约拥有者提取出ether
    function withdraw(uint256 amount) public onlyOwner returns (bool success) {
      require(amount <= address(this).balance, "ICO: function withdraw invalid input");
      payable(_msgSender()).transfer(amount);
      return true;
    }

    function getBalance(address account) public view returns (uint256) {
      return balanceOf(account)/(10**uint256(decimals()));
    }
}
