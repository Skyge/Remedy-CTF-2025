// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Challenge} from "../src/Challenge.sol";
import {Exploit} from "../src/solution/Exploit.sol";

contract VaultTest is Test {
    Challenge public challenge;
    Exploit public exploit;

    function setUp() external {
        address player = makeAddr("player");
        challenge = new Challenge(player);

        exploit = new Exploit(challenge);
        exploit.pwn1();
    }

    function testExploit() external {
        exploit.pwn2();
        assertTrue(challenge.isSolved());
    }
}
