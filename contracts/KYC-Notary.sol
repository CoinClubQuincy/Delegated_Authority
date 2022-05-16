pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
interface Notary_interface{
    function checkContractStatus(address _Contract) external view returns(bool);
    function NotorizeContract(address _KYC_Contract, bool _status) external returns(bool,string memory);
}
contract Notary is Notary_interface,ERC1155{
    uint256 public constant NotorizorKey = 0;
    //set mapping for contracts created & logged into KYCLedger
    mapping(address => KYCLedger) ledger;
    struct KYCLedger{
        bool status;
    }
    //set KYC contract & launch constructor 
    KYC public kyc;
    constructor(uint keyAmmount) ERC1155("Notorizer Token"){
        _mint(msg.sender, NotorizorKey,keyAmmount, "");
    }
    //check if executer hold token to proove they own the contract
    modifier OnlyOwner{
        require(balanceOf(msg.sender, NotorizorKey) > 0,"you are not the holder of this KYC contract");
        _;
    }
    //anyone can check the status of a KYC contract
    function checkContractStatus(address _Contract) public view returns(bool){
        return ledger[_Contract].status;
    }
    // Owner can notorize contract
    function NotorizeContract(address _KYC_Contract, bool _status) OnlyOwner public returns(bool,string memory){
        ledger[_KYC_Contract].status =  _status;  
        return (true,"status of {_KYC_Contract} changed to {_status}");     
    }
    //Users can fill out KYCs fourm 
    function Launch_KYC_Contract(address _initialcaller,uint _keyAmomunt,string memory _legal_Name,string memory _permanentAddress,string memory _passport,string memory _SSN,string memory _driversLicenceNumber) public returns(bool,address){
        require(_initialcaller==msg.sender, "initialcaller must be msg.sender");
        kyc = new KYC(_initialcaller,address(this),_keyAmomunt,_legal_Name,_permanentAddress,_passport,_SSN,_driversLicenceNumber);
        ledger[address(kyc)] = KYCLedger(false);
        return (true, address(kyc));
    }
}
interface KYC_Interface{
    function ConfirmHolder(address _checkUser)external view returns(bool);
    function ViewData() external view returns(string memory ,string memory,string memory,string memory,string memory);
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
    constructor(address _user,address _KYC_NotaryAddress, uint keyAmmount, string memory legal_Name,string memory permanentAddress,string memory passport,string memory SSN,string memory driversLicenceNumber) ERC1155("KYC contract"){
        KYC_NotaryAddress =_KYC_NotaryAddress;
        _mint(_user, Key,keyAmmount, "");
    }
    //checks to see if caller is holding token
    function ConfirmHolder(address _checkUser)public view returns(bool){
        require(balanceOf(_checkUser, Key) > 0,"user does not hold proper crededentials");
        return true;
    }
    //check data contents
    function ViewData() public view Authorized_Users returns(string memory ,string memory,string memory,string memory,string memory){
        return (legal_Name,permanentAddress,passport,SSN,driversLicenceNumber);
    }
}
