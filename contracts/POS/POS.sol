// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "@openzeppelin/contracts/access/Ownable.sol";

contract POS is Ownable {

    uint256 idHelper;

    struct PaymentInformation {
        address user;
        uint256 block;
        uint256 productId;
        uint256 amount;
        string metadataA;
        string metadataB;
        bool isRegistered;
    }

    /// sales ID > payment
    mapping(uint256 => PaymentInformation) public history;

    /// @dev Events of the contract
    event TokenAdded(address token);
    event TokenRemoved(address token);
    event ItemPurchase(address user, uint256 pid, uint256 amount, string metadataA, string metadataB);


    /// @notice ERC20 Address -> Bool
    mapping(address => bool) public enabled;

    /**
    @notice Method for adding payment token
    @dev Only admin
    @param token ERC20 token address
    */
    function add(address token) external onlyOwner {
        require(!enabled[token], "token already added");
        enabled[token] = true;
        emit TokenAdded(token);
    }

    /**
    @notice Method for removing payment token
    @dev Only admin
    @param token ERC20 token address
    */
    function remove(address token) external onlyOwner {
        require(enabled[token], "token not exist");
        enabled[token] = false;
        emit TokenRemoved(token);
    }

    function buy(uint256 _productId, uint256 _amount, string memory _metadataA, string memory _metadataB) public {
        // missing the process of validating product id and amount transfered with swap
        history[idHelper] = PaymentInformation(msg.sender, block.number, _productId, _amount, _metadataA, _metadataB, true);
        idHelper+=1;
        emit ItemPurchase(msg.sender, _productId, _amount, _metadataA, _metadataB);
    }
}
