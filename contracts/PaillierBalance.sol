/*
SPDX-License-Identifier: MIT
*/
pragma solidity >=0.8.0;
contract PaillierBalance {

    /*{REPLACE} - DO NOT TOUCH - AUTO GENERATED!!*/
    /*{END} - DO NOT TOUCH - AUTO GENERATED!!*/            
    
    

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