/*
SPDX-License-Identifier: MIT
*/
pragma solidity >=0.8.0;
contract PaillierBalance {

/*{REPLACE} - DO NOT TOUCH - AUTO GENERATED!!*/
uint public encryptedBalance = 0xb69809bb8b3f6ee5b85cc1213ef6fc7841b0156f9cbb14b9da49c5bb8fe9896a;
uint public g = 0x15ea0e95d8f3a50b594f8b02082bb68a2caac7f9e8d42980e99753191a69dd34;
uint public n = 0xe633c2746ca545c587d6afed2a0ea88f;
uint nSquared = 0xcf010be04150ecd5de6c5e1e6b864e376844cffb4d86639591946aebca9fffe1;
/*{END} - DO NOT TOUCH - AUTO GENERATED!!*/
    
    struct Benchmark {
        string name;
        uint sum;
        address[] participants;
    }

    bytes32[] public benchmarks;
    mapping(bytes32 => Benchmark) benchmarkStructs;

    address public controller;

    event Entry(
        address indexed _from,
        uint indexed newBalance,
        uint encryptedChange
    );
      
    constructor () {                                    
        controller = msg.sender;
    }

    function createBenchmark(string name) public {

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