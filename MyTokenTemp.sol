contract MyTokenTemp {
    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    uint256 public tokenValue;
    uint256 private beneficiary;

    function MyTokenTemp(uint256 initialSupply, uint256 value) {
        balanceOf[msg.sender] = initialSupply;              // Give the creator all initial tokens
        tokenValue = value;                                 // set value of token
        beneficiary = msg.sender                            // store address of contract instantiator 
    }

    /* Send coins */
    function buy(uint256 _value) payable {
        require(balanceOf[beneficiary] >= _value);                    // Check if the sender has enough
        require(balanceOf[msg.sender] + _value >= balanceOf[_to]);      // Check for overflows
        require(msg.sender.balance >= _value * tokenValue * 10**18);    // Check buyer has enough ether
        beneficiary.transfer(_value * tokenValue * 10 ** 18);         // Send ether from buyer to owner
        balanceOf[benficiary] -= _value;                             // Subtract from the sender
        balanceOf[msg.sender] += _value;                                // Add the same to the recipient
}
