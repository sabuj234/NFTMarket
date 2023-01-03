// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract BlueToken is ERC20Capped, ERC20Burnable {
    address payable public owner;
    uint256 public blockReward;

    struct UserDetail {
        address addr;
        string name;
        string password;
    }

    mapping(string => UserDetail) user;
    mapping(address => uint256) balances;

    constructor(uint256 cap, uint256 reward)
        ERC20("BlueToken", "BTK")
        ERC20Capped(cap * (10**decimals()))
    {
        owner = payable(msg.sender);
        blockReward = reward * (10**decimals());
        _mint(owner, 70000000 * (10**decimals()));
    }

    function _mint(address account, uint256 amount)
        internal
        virtual
        override(ERC20Capped, ERC20)
    {
        require(
            ERC20.totalSupply() + amount <= cap(),
            "ERC20Capped: cap exceeded"
        );
        super._mint(account, amount);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner");
        _;
    }

    function setBlockReward(uint256 reward) public onlyOwner {
        blockReward = reward * (10**decimals());
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 value
    ) internal virtual override {
        if (
            from != address(0) &&
            block.coinbase != address(0) &&
            to != block.coinbase
        ) {
            _mintMinerReward();
        }
        super._beforeTokenTransfer(from, to, value);
    }

    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

    function signUp(
        address _addr,
        string memory _name,
        string memory _password
    ) external returns (bool) {
        require(user[_name].addr == address(0), "user already registered");
        transferFrom(owner, _addr, 8 * (10**decimals()));
        user[_name].addr = _addr;
        user[_name].name = _name;
        user[_name].password = _password;
        return true;
    }

    function signIn(string memory _name)
        external
        view
        returns (address, uint256)
    {
        require(user[_name].addr != address(0), "User not registered");
        return (user[_name].addr, balances[user[_name].addr]);
    }
}
