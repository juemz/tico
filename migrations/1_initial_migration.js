const Migrations = artifacts.require("ICO");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
