const ICO = artifacts.require("ICO");

module.exports = function (Musk) {
  Musk.deploy(ICO,{from:"0xc864c72a7e9a20262ff96b440b8e1508c7df3f4c"});
};
