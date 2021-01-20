const Web3 = require('web3');
const provider = new Web3.providers.HttpProvider("http://127.0.0.1:8545");
const contract = require("@truffle/contract");

const p_artifact = require('../build/contracts/PaillierBalance.json');
var PaillierBalance = contract(p_artifact)

PaillierBalance.setProvider(provider);

async function getPBalance(){
    const instance = await PaillierBalance.deployed();
    return await instance.encryptedBalance.call();
}

async function addPBalance(balance){
    const instance = await PaillierBalance.deployed();
    //const account = await instance.web3.eth.getAccounts()[0]
    let data = await instance.homomorphicAdd(balance, {from: "0x2b5c8d4533EA269256cCefD9CF300aE04d1Ba32f"});
    return await getPBalance()
}

module.exports = {getPBalance, addPBalance}