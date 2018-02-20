pragma solidity ^0.4.18;

contract MyToken {
    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf; 
    uint256 public tokenPrice;   // price of token in wei
    address private beneficiary;


    /* Initializes contract with initial supply tokens to the creator of the contract */
    function MyToken(uint256 initialSupply, uint256 value) {
        balanceOf[msg.sender] = initialSupply;              // Give the creator all initial tokens
        tokenPrice = value;                                 // set the tokenValue to the input value
        beneficiary = msg.sender;
    }

    /* Send coins - Primary */ 
    function buy(uint256 _numTokens) payable {
        uint256 tokenAmountinWei = _numTokens * tokenPrice;

        require(balanceOf[beneficiary] >= _numTokens); 
        require(balanceOf[msg.sender] + _numTokens >= balanceOf[msg.sender]);
        //require(tokenAmountinWei == msg.value);

        bool validPurchase = forwardFunds(beneficiary, msg.sender, tokenAmountinWei);

        if(validPurchase){
            transfer(msg.sender, beneficiary, _numTokens);
        }
    }

    function forwardFunds(address _to, address _from, uint256 tokenAmountinWei) internal returns(bool){
       require(beneficiary.balance >= tokenAmountinWei);
       require(msg.sender.balance + tokenAmountinWei >= msg.sender.balance);


       beneficiary.transfer(tokenAmountinWei);


       return true;
    }

    function transfer(address _to, address _from, uint256 _value) {
        require(balanceOf[msg.sender] >= _value);           // Check if the sender has enough
        require(balanceOf[_to] + _value >= balanceOf[_to]); // Check for overflows
        balanceOf[msg.sender] -= _value;                    // Subtract from the sender
        balanceOf[_to] += _value;                           // Add the same to the recipient
    }

    function getBalanceOf(address _account) public view returns (uint256) {
        return balanceOf[_account];
    }
}