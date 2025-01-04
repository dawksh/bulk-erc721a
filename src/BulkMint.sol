// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {ITokenERC721} from "./interfaces/ITokenERC721.sol";

contract BulkMint {
    ITokenERC721 token;
    constructor(address _token) {
        token = ITokenERC721(_token);
    }

    function bulkMint(
        address[] calldata recipients,
        string[] calldata uris
    ) external {
        uint length = recipients.length;
        for (uint i; i < length; ) {
            token.mintTo(recipients[i], uris[i]);
            unchecked {
                i++;
            }
        }
    }
}
