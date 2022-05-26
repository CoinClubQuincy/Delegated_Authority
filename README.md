# Delegated Authority

As a delegated Authority you can have KYC contracts created when users submit a form and generate a contract in the contract will their user data be stored both the user who generated the contract and the original dapp creator will have access tokens to access their data. the user will only be able to view and show proof of their own data while the main application administrator can view all user data and approve all user KYC contracts.

Third Party smart contracts and DApps can use the KYC user auth token as a form of delegated Identification while trusting the  Delegated authority (Bank,Exchange,broker) to provide the correct status of the authenticity of the Identities 

![KYC-Notary Contract (3)](https://user-images.githubusercontent.com/16103963/167725224-07c444d8-9c3f-4b29-a3a8-0e9856d77c22.png)

#  Variables

    string public legal_Name;  
    string private permanentAddress;
    string private passport;
    string private SSN;
    string private driversLicenceNumber;

Variables can be modified to hold any number of user PII Data 



This contract is a proof of concept of how KYC notary contracts could work on the XDC network by having one contract produce a ledger of other contracts and  have the secondary contract hold the private information


