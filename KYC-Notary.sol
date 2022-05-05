pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
contract ContractBook{
    constructor(){}
}

interface KYC_Notary_Interface{
    function check4Token() public view returns(bool);
}

contract KYC_Notary is KYC_Notary_Interface,ERC1155{
    uint256 public constant Key = 0;

    string private legal_Name;
    string private permanentAddress;
    string private passport;
    string private SSN; 
    string private driversLicenceNumber; 
    //sets Notary address and ammount of keys
    constructor(address KYC_NotaryAddress, uint keyAmmount) ERC1155("KYC Contract Token Notary: {KYC_NotaryAddress}"){
        _mint(msg.sender, Key,keyAmmount, "");
    }
    //checks to see if caller is holding token
    function check4Token() public view returns(bool){
        require(balanceOf(msg.sender, 0),"you are not the holder of this KYC contract");
        return true;
    }    
}
