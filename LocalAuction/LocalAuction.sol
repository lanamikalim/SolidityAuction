import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Auction2{
    address payable public beneficiaryAddress;
    address payable public owner;
    uint public auctionClose;
    uint256 public testnum;
     IERC721 public nft;
    uint public nftId;
     address public topBidder;
    uint public topBid;
    
     function Auction( uint biddingTime, address payable beneficiary,address _nft,
        uint _nftId) public{
        beneficiaryAddress = beneficiary;
        nft = IERC721(_nft);
        nftId = _nftId;
        auctionClose = block.timestamp + biddingTime;
        testnum = 0;
        
    }
    /**
     * Note: input address of dog nft is invalid when constructing SimpleAuction)
     * nft: 0x13066ee900a8c4e2c9cd7ce0096adf9b907d0cff
     * */
  
    function closeAuction() public{
        require(block.timestamp >= auctionClose);
      
        
    }
    
    function bid() public{
        //CHajkjfhjkhdajkfdjkthe 
    }

    
    function transferNFT(address owner) public payable{
        //msg.sender
        //0x2ad7aa2a14a761c4e2ef3089d6dccb204afc3534
        //Okay this is now working yay
        nft.safeTransferFrom(owner,beneficiaryAddress,nftId);

    }
    
}