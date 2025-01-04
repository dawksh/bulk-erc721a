// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.11;

/// @title Interface for TokenERC721
interface ITokenERC721 {
    /// @dev Struct to represent a Mint Request
    struct MintRequest {
        address to;
        address royaltyRecipient;
        uint256 royaltyBps;
        address primarySaleRecipient;
        string uri;
        uint256 price;
        address currency;
        uint128 validityStartTimestamp;
        uint128 validityEndTimestamp;
        bytes32 uid;
    }

    // Events
    event TokensMinted(address indexed to, uint256 indexed tokenId, string uri);
    event TokensMintedWithSignature(
        address indexed signer,
        address indexed receiver,
        uint256 indexed tokenId,
        MintRequest req
    );
    event PrimarySaleRecipientUpdated(address indexed newRecipient);
    event DefaultRoyalty(address indexed recipient, uint256 bps);
    event RoyaltyForToken(
        uint256 indexed tokenId,
        address indexed recipient,
        uint256 bps
    );
    event PlatformFeeInfoUpdated(address indexed recipient, uint256 bps);
    event OwnerUpdated(address indexed previousOwner, address indexed newOwner);

    // Public Functions
    function contractType() external pure returns (bytes32);
    function contractVersion() external pure returns (uint8);
    function owner() external view returns (address);
    function verify(
        MintRequest calldata req,
        bytes calldata signature
    ) external view returns (bool, address);
    function tokenURI(uint256 tokenId) external view returns (string memory);
    function balanceOf(address addr) external view returns (uint256);

    // External Functions
    function royaltyInfo(
        uint256 tokenId,
        uint256 salePrice
    ) external view returns (address receiver, uint256 royaltyAmount);
    function mintTo(address to, string calldata uri) external returns (uint256);
    function mintWithSignature(
        MintRequest calldata req,
        bytes calldata signature
    ) external payable returns (uint256 tokenIdMinted);

    // Setter Functions
    function setPrimarySaleRecipient(address saleRecipient) external;
    function setDefaultRoyaltyInfo(
        address royaltyRecipient,
        uint256 royaltyBps
    ) external;
    function setRoyaltyInfoForToken(
        uint256 tokenId,
        address recipient,
        uint256 bps
    ) external;
    function setPlatformFeeInfo(
        address platformFeeRecipient,
        uint256 platformFeeBps
    ) external;
    function setOwner(address newOwner) external;
    function setContractURI(string calldata uri) external;
    function grantRole(bytes32 role, address account) external;

    // Getter Functions
    function getPlatformFeeInfo() external view returns (address, uint16);
    function getDefaultRoyaltyInfo() external view returns (address, uint16);
    function getRoyaltyInfoForToken(
        uint256 tokenId
    ) external view returns (address, uint16);
}
