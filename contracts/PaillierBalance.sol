/*
SPDX-License-Identifier: MIT
*/
pragma solidity >=0.8.0;
contract PaillierBalance {

/*{REPLACE}*/
uint public encryptedBalance = 0x9128877dca4023c5fbca1664779e343c5d952cacbb48ad42714eda6462a841aa;
uint public g = 0xa4f18c8223fb935d0f1ad76559ecfdefe699c15ae3a9816ae48e00c9d0ae3a5c;
uint public n = 0xf7cfbe1fcf65944cc477758568aafeef;
/*{END}*/
    
    

    address public controller;
    uint nSquared;

    event LogUint(string, uint);

    event Entry(
        address indexed _from,
        uint indexed newBalance,
        uint encryptedChange
    );
      
    constructor () {                                    
        controller = msg.sender;
        uint nSquaredTemp;
        uint nInner = n;
        assembly {
            let _n := nInner
            nSquaredTemp := exp(_n, 2)
        }
        nSquared = nSquaredTemp;
    }
                                

    function homomorphicAdd(uint encryptedChange) public {
        /* require(msg.sender == controller); */
        uint encryptedBalanceInner = encryptedBalance;  
        uint nSquaredInner = nSquared; 
        uint encryptedBalanceTemp;                                          
        assembly {
            let _encryptedBalance := encryptedBalanceInner                  
            let _encryptedChange := encryptedChange             
            let _nSquared := nSquaredInner                  
            encryptedBalanceTemp := mulmod(_encryptedBalance, _encryptedChange,_nSquared)
        }
        encryptedBalance = encryptedBalanceTemp;  
        emit Entry(msg.sender, encryptedBalanceTemp, encryptedChange);                  
    }
}