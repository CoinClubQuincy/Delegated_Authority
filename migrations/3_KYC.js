const KYC = artifacts.require("KYC");

module.exports = function (deployer) {
  deployer.deploy(KYC, 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,1,"Q","Q","Q","Q","Q");
};