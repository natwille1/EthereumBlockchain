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

        require(balanceOf[beneficiary] >= _numTokens);                                  //bene got enough tokens
        require(balanceOf[msg.sender] + _numTokens >= balanceOf[msg.sender]);           //no overflow
        //require(tokenAmountinWei == msg.value);

        require(msg.sender.balance >= tokenAmountinWei);                               //msg.sender has enough wei

        transfer(beneficiary, msg.sender, _numTokens);
        beneficiary.transfer(msg.value);
    }

    function forwardFunds(uint256 tokenAmountinWei) internal returns(bool){
       require(beneficiary.balance >= tokenAmountinWei);
       require(msg.sender.balance + tokenAmountinWei >= msg.sender.balance);


       return true;
    }

    function transfer(address _from, address _to, uint256 _value) {
        require(balanceOf[_from] >= _value);           // Check if the sender has enough
        require(balanceOf[_to] + _value >= balanceOf[_to]); // Check for overflows
        balanceOf[_from] -= _value;                    // Subtract from the sender
        balanceOf[_to] += _value;                           // Add the same to the recipient
    }

    function getBalanceOf(address _account) public view returns (uint256) {
        return balanceOf[_account];
    }

    function getBene() public view returns (address) {      //returns address of bene should be the same as business id
        return beneficiary;
    }

    function getWei(address _account) public view returns (uint256) {
        return _account.balance;
    }

    function transferWei() payable {
       beneficiary.transfer(msg.value);
    }


}












