pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
interface Notary_interface{
    function check4Contract(address _Contract) external view returns(bool);
    function NotorizeContract(address _KYC_Contract, bool _status) external view returns(bool,string memory);
}
contract Notary is Notary_interface,ERC1155{
    uint256 public constant NotorizorKey = 0;

    mapping(address => NotaryLedger) ledger;
    struct NotaryLedger{
        bool status;
    }
    constructor(uint keyAmmount) ERC1155("Notorizer Token"){
        _mint(msg.sender, NotorizorKey,keyAmmount, "");
    }
    //check if executer hold token to proove they own the contract
    modifier OnlyOwner{
        require(balanceOf(msg.sender, NotorizorKey) > 0,"you are not the holder of this KYC contract");
        _;
    }
    //anyone can check the status of a KYC contract
    function check4Contract(address _Contract) public view returns(bool){
        return ledger[_Contract].status;
    }
    // Owner can notorize contract
    function NotorizeContract(address _KYC_Contract, bool _status) OnlyOwner public view returns(bool,string memory){
        _status = ledger[_KYC_Contract].status;  
        return (true,"status of {_KYC_Contract} changed to {_status}");     
    }
}

interface KYC_Interface{
    function check4Token() external view returns(bool);
}
contract KYC is KYC_Interface,ERC1155{
    uint256 private constant Key = 0;
    address public KYC_NotaryAddress;
    //Any KYC user data can be placed here
    string public legal_Name;
    string private permanentAddress;
    string private passport;
    string private SSN; 
    string private driversLicenceNumber; 
    //checks if authorized users hold their token to view data
    modifier Authorized_Users{
        require(balanceOf(msg.sender, Key) > 0 || Notary(KYC_NotaryAddress).balanceOf(msg.sender, Key) > 0,"you are not the holder of this KYC contract");
        _;
    }
    //launches contracts and variables
    constructor(address _KYC_NotaryAddress, uint keyAmmount, string memory legal_Name,string memory permanentAddress,string memory passport,string memory SSN,string memory driversLicenceNumber) ERC1155("KYC contract"){
        KYC_NotaryAddress =_KYC_NotaryAddress;
        _mint(msg.sender, Key,keyAmmount, "");
    }
    //checks to see if caller is holding token
    function check4Token() public view returns(bool){
        require(balanceOf(msg.sender, Key) > 0,"you are not the holder of this KYC contract");
        return true;
    }
    //check data contents
    function ViewData() public view Authorized_Users returns(string memory ,string memory,string memory,string memory,string memory){
        return (legal_Name,permanentAddress,passport,SSN,driversLicenceNumber);
    }
}
