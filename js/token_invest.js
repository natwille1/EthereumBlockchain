//Back end stuff------------
var Web3 = require('web3');
var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:9545"));
abi = JSON.parse('[{"constant": true, "inputs": [], "name": "tokenPrice", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "address"} ], "name": "balanceOf", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "_account", "type": "address"} ], "name": "getWei", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "_account", "type": "address"} ], "name": "getBalanceOf", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "getBene", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"inputs": [{"name": "initialSupply", "type": "uint256"}, {"name": "value", "type": "uint256"} ], "payable": false, "stateMutability": "nonpayable", "type": "constructor"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "from", "type": "address"}, {"indexed": true, "name": "to", "type": "address"}, {"indexed": false, "name": "value", "type": "uint256"} ], "name": "Transfer", "type": "event"}, {"constant": false, "inputs": [], "name": "transferWei", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "sell", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [{"name": "_numTokens", "type": "uint256"} ], "name": "buy", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"}, {"constant": false, "inputs": [{"name": "_from", "type": "address"}, {"name": "_to", "type": "address"}, {"name": "_value", "type": "uint256"} ], "name": "transfer", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}]'); 
contract = web3.eth.contract(abi);

var contractAddress = '0xeec918d74c746167564401103096d45bbd494b74';
//var contractAddress2 = '0xfb88de099e13c3ed21f80a7a1e49f8caecf10df6';

contractInstance = contract.at(contractAddress);
//contractInstance2 = contract.at(contractAddress2);

console.log(contractInstance);

function displayLogin() {
  var addr = document.getElementById("walletAddress").value;
  console.log(addr);
}

function saveAddress() {
    var addr = document.getElementById("walletAddress").value;
    document.cookie = 'walletAddress:'+addr; //Set the cookie
}

function getAddress() {
    var start = document.cookie.indexOf('walletAddress:'); //Get the location of the cookie value
    var stop = document.cookie.indexOf(';'); //Get the end of the cookie value

    return document.cookie.substring(start+14, stop); //Return the value of the cookie (+5 because 'snum:' is 5 chars long)

}

function buyToken() {
  var amount = document.getElementById("tokenamount").value;
  console.log("amount" + amount);
  //var address = getAddress();
  //console.log(address);
  var addr = document.getElementById("walletAddress").value;
  var totalPrice = amount * contractInstance.tokenPrice();
  //contractInstance.buy(amount, {from:web3.eth.accounts[1], gas: 4700000, value: web3.toWei(5, "ether")});
  contractInstance.buy(amount, {from:addr, gas: 4700000, value: web3.toWei(totalPrice, "ether")});
  //var bal = contractInstance.getWei(web3.eth.accounts[1]);
  //console.log(bal)
  console.log("yes");
} 

//function buyToken2() {
//  var amount = document.getElementById("tokenamount2").value;
//  var totalPrice = amount * contractInstance2.tokenPrice();
//  contractInstance2.buy(amount, {from:web3.eth.accounts[1], gas: 4700000, value: web3.toWei(totalPrice, "ether")});
//} 
//Back end stuff

// Get the modal
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(e) {
  if (!e.target.matches('.dropbtn')) {
    var myDropdown = document.getElementById("myDropdown");
      if (myDropdown.classList.contains('show')) {
        myDropdown.classList.remove('show');
      }
  }
}
function myFunction2() {
  var input, filter, table, tr, td, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
    if (td) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
$()
