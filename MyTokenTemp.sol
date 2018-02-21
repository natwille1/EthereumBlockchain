contract MyTokenTemp {
    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    
    address[] public divAddress = new address[](10);           // store addresses of token purchasers
    
    uint256 public tokenValue;
    uint256 public beneficiary;
    unit256 public totalSupply;

    function MyTokenTemp(uint256 initialSupply, uint256 value) {
        balanceOf[msg.sender] = initialSupply;              // Give the creator all initial tokens
        tokenValue = value;                                 // set value of token
        beneficiary = msg.sender;                       // store address of contract instantiator 
        totalSupply = intialSupply;
    }

    /* Send coins */
    function buy(uint256 _value) payable {
        require(balanceOf[beneficiary] >= _value);                    // Check if the sender has enough
        require(balanceOf[msg.sender] + _value >= balanceOf[_to]);      // Check for overflows
        require(msg.sender.balance >= _value * tokenValue * 10**18);    // Check buyer has enough ether
        beneficiary.transfer(_value * tokenValue * 10 ** 18);         // Send ether from buyer to owner
        balanceOf[benficiary] -= _value;                             // Subtract from the sender
        balanceOf[msg.sender] += _value;                                // Add the same to the recipient
        
        if(checkTokenHolder(msg.sender) == false){                       // add buyer address to list of token holders
            addTokenHolder(msg.sender);    
        }

    /* supply dividends */
    function supplyDiv() onlyOwner {
        for(uint i = 0; i < 10; i++){
            recipient = divAddress[i];
            if(recipient == 0x0){
                return;
            }
            else{
                recipient.transfer(beneficiary.balance * balanceOf[recipient] / totalSupply)
            }
        }
    }

    /* add address to list of token holders */
    function addTokenHolder(address buyer) private {
        for(uint i = 0; i < 10; i++){
            if(divAddress[i] == 0x0){
                divAddress[i] = buyer;
                return;
            }
        }
    }

    /* check if address is a token holder */
    function checkTokenHolder(address buyer) private returns(bool) {
        for(uint i = 0; i < 10; i++){
            if(divAddress[i] == buyer){
                return true;
            }
        }
        return false;
    }
}
