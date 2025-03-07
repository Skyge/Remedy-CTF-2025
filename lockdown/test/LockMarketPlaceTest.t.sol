// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Challenge} from "src/Challenge.sol";
import {Exploit} from "src/solution/Exploit.sol";

contract LockMarketPlaceTest is Test {
    Exploit internal exploit;
    Challenge internal challenge;
    IERC20 internal usdc;

    function setUp() external {
        vm.createSelectFork(vm.envString("MAINNET_RPC_URL"), 21_690_640);

        exploit = new Exploit();
        challenge = new Challenge((address(exploit)));
        
        usdc = challenge.USDC();
        
        // Distribute 1_000_520e6 USDC to the challenge contract
        deal(address(usdc), address(challenge), 1_000_520e6);
        // Deploy the whole system
        challenge.deploy();

        // Transfer 500 USDC to the exploit contract
        vm.startPrank(challenge.PLAYER());
        usdc.transfer(address(exploit), 500e6);
        vm.stopPrank();
    } 

    function testExploit() external {
        exploit.pwn(challenge);
        assertTrue(challenge.isSolved());
    }
}
