// SPDX-Licence-Identifier:MIT

pragma solidity ^0.8.17;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);

    function balanceOf(address account) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract Faucet {
    address payable owner;
    IERC20 public token;

    event withDraw(address indexed to, uint256 indexed amount);
    event Deposit(address indexed from, uint256 indexed amount);

    uint256 public withdrawlAmount = 50 * (10**18);

    mapping(address => uint256) nextAccessTime;
    uint256 public lockTime = 1 minutes;

    constructor(address tokenAddress) {
        token = IERC20(tokenAddress);
        owner = payable(msg.sender);
    }

    function requestTokens() public {
        require(msg.sender != address(0), "Invalid Account");
        require(
            token.balanceOf(address(this)) >= withdrawlAmount,
            "Insufficient balance in the faucet for withdrawl request"
        );
        require(
            block.timestamp >= nextAccessTime[msg.sender],
            "Insufficient time elapsed since last withdrawl - try again later"
        );
        nextAccessTime[msg.sender] = block.timestamp + lockTime;
        token.transfer(msg.sender, withdrawlAmount);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function getBalance() external view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function withDrawal() external onlyOwner {
        emit withDraw(msg.sender, token.balanceOf(address(this)));
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can access");
        _;
    }
}
