const Notary = artifacts.require("Notary");
const KYC = artifacts.require("KYC");

contract(Notary, () => {
    it("Launch Notary contract", async() =>  {
        console.log(Notary.address);
    })
})