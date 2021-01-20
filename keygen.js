const paillierBigint = require('paillier-bigint')
const fs = require('fs/promises');
const bigintConversion = require('bigint-conversion');



async function paillierTest () {
  const { publicKey, privateKey } = await paillierBigint.generateRandomKeys(128)
    let pub = {};
    let priv = {}
    pub.n = '0x'+bigintConversion.bigintToHex(publicKey.n)
    pub.g = '0x'+bigintConversion.bigintToHex(publicKey.g)

    priv.lambda = '0x'+bigintConversion.bigintToHex(privateKey.lambda)
    priv.mu = '0x'+bigintConversion.bigintToHex(privateKey.mu)


   await fs.writeFile('pubkey.json', JSON.stringify(pub,null,4));
   await fs.writeFile('privkey.json', JSON.stringify(priv,null,4));

   const pubKey = new paillierBigint.PublicKey(BigInt(pub.n), BigInt(pub.g))
   // const privateKey = new paillierBigint.PrivateKey(priv.lambda, priv.mu, publicKey)

   let encrypted = ['/*{REPLACE} - DO NOT TOUCH - AUTO GENERATED!!*/','uint public encryptedBalance = 0x'+bigintConversion.bigintToHex(pubKey.encrypt(1n)) + ';',
   'uint public g = ' + pub.g + ';',
   'uint public n = ' + pub.n + ';', 
   'uint nSquared = 0x' + bigintConversion.bigintToHex(publicKey.n ** 2n) + ';',
   '/*{END} - DO NOT TOUCH - AUTO GENERATED!!*/'];

   let soliditycontract = await fs.readFile('./contracts/PaillierBalance.sol');
   let soliditycontracttext = await soliditycontract.toString();
   let textarray = soliditycontracttext.split('\n');
   let begin = textarray.findIndex((element) => element.includes('/*{REPLACE}'))
   let end = textarray.findIndex((element) => element.includes('/*{END}'))
   console.log(begin, end)
   if(end < 1 || begin < 1){
       throw new Error('file corrupt')
   }

   if(end == begin){
    textarray.splice(begin, 1, ...encrypted)
   }else{
    textarray.splice(begin, end-begin+1, ...encrypted)
   }

   

   await fs.writeFile('./contracts/PaillierBalance.sol', textarray.join('\n'))

}
paillierTest()