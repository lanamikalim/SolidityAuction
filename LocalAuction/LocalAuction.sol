import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Auction2{
    address payable public beneficiaryAddress;
    address public nftOwner;
    uint public auctionClose;
    uint256 public testnum;
     IERC721 public nft;
    uint public nftId;
     address public topBidder;
    uint public topBid;
    mapping (address => uint) public allBids;
    uint public maxBids;
    uint public amountOfBids;
    uint256 public buyNowPrice;

     function Auction(address nftowner, address _nft, uint _nftId, uint maxbids, uint256 buyNow) public{
        nft = IERC721(_nft);
        nftId = _nftId;
       // auctionClose = block.timestamp + biddingTime;
        testnum = 0;
        nftOwner= nftowner;
        maxBids = maxbids;
        buyNowPrice = buyNow;
    }
 
     
    //lets user bid an amount, if amount of bids is greater than 
    //presumably working
     function bid(uint bidAmount, address bidder) public{
        if(bidAmount == buyNowPrice){
            closeAuction();
        }
        updateTopBid(bidAmount,bidder);
        allBids[bidder] = bidAmount;
        amountOfBids++;
        if(amountOfBids == maxBids){
          closeAuction();
        }
    }
    
    //working
    function updateTopBid(uint bidAmount,address bidder) public{
        if(bidAmount >topBid){
            topBid = bidAmount;
            topBidder = bidder;
        }
        
        
    }
    function closeAuction() public{
        transferNFT(nftOwner);
    }
    
    
//Setup Note: -run  remixd -s . --remix-ide https://remix.ethereum.org/ in github directory before connecting to localhost
//Runtime notes: -deploy thingy - create nft with the contract address as the owner -use constructor on contract, put my address as beneficiaryAddress -transferNFT with contract address as owner
    
    //current source of error: transferring nft that is not owned
    function transferNFT(address owner) public payable{
        //Okay this is now working yay
        nft.safeTransferFrom(owner,topBidder,nftId);

    }
    
}