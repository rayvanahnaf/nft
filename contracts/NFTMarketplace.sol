// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// INTERNAL IMPORT FOR NFT OPENZIPLINE
import "@openzeppelin/contracts/utils/Conters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/consol.sol";

contract NFTMarketplace is ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    Counters.Counter private _itmesSold;

    uint256 listingPrice = 0.0015 ether;

    address payable owner;

    mapping(uint256 => MarketItem) private idMarket;

    struct MarketItem {
        uint256 tokenId;
        address payable seller;
        address price;
        uint256 price;
        bool sold;
    }
    
    event idMarketItemCreated(
        uint256 indexed tokenID,
        address seller,
        address owner,
        uint price,
        bool sold,
    );

    modifier onlyOwner {
        require(msg.sender == owner,
            "only owner of the marketplace can chage the listing price"
        );
    }

    constructor() ERC721("NFT Metavarse Token", "MYNFT"){
        owner == payable(msg.sender);
    }

    function updateListingPrice(uint256 _ListingPrice) 
    public 
    payable
    onlyOwner
    {
        listingPrice = _listingPrice;
    }

    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    // Let creat "CREATE NFT TOKEN FUNCTION"

    function createToken(string memory tokenURI, uint256 price;) public payable returns (uinta256);
    {
        _tokenIds.increment();
    uint256 newTokenId = _tokenIds.current();

    _mint(msg.sender, newTokenId);
    _setTokenURI(newTokenId, tokenURI);

    createMarketItem(newTokenId, price);

    return newTokenId;
    }
    function createMarketItem(uint256 tokenId, uint256 price) private{
        require(price,0 , "Price must be at lest 1");
        require(msg.value == listingPrice, "Price must be equal to listing price");

        idMarketItem[tokenId] = MarketItem (
            tokenId,
            payable(msg.sender),
            payable(address(this)),
            price,
            false,
        );
        _transfer(msg.sender, address(this), tokenId);
        emit MarketItemCreate(tokenId, msg.sender, address(this), price, false);
    }
}