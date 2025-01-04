// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ITokenERC721} from "../src/interfaces/ITokenERC721.sol";
import {BulkMint} from "../src/BulkMint.sol";

contract BulkMintTest is Test {
    BulkMint public bulkMint;
    address authority = 0x07BfC62f5D44250E0D24e3ad4682128F1AF0CaAA;
    ITokenERC721 token;
    address[] recipients;
    string[] uris;

    function setUp() public {
        bulkMint = new BulkMint(0xCcaf48080356af8e45564b63687877AF2CA34950);
        token = ITokenERC721(0xCcaf48080356af8e45564b63687877AF2CA34950);

        recipients = new address[](10);
        uris = new string[](10);

        for (uint i = 0; i < 10; ) {
            recipients[i] = address(0x28172273CC1E0395F3473EC6eD062B6fdFb15940);
            uris[i] = "TEST URI";
            unchecked {
                i++;
            }
        }

        vm.startPrank(0xFA79FD0FEF158Be87bF5BE307076B176eFf38f80);
        token.grantRole(
            0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6,
            address(bulkMint)
        );
        vm.stopPrank();
    }
    function testNormalMint() public {
        vm.startPrank(authority);
        for (uint i; i < 10; ) {
            token.mintTo(
                address(0x28172273CC1E0395F3473EC6eD062B6fdFb15940),
                "TEST URI"
            );
            unchecked {
                i++;
            }
        }
        assertEq(
            token.balanceOf(0x28172273CC1E0395F3473EC6eD062B6fdFb15940),
            10
        );
        vm.stopPrank();
    }
    function testBulkMint() public {
        bulkMint.bulkMint(recipients, uris);

        assertEq(
            token.balanceOf(0x28172273CC1E0395F3473EC6eD062B6fdFb15940),
            10
        );
    }
}
