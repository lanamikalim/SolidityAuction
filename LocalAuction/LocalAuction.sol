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
    bool public auctionIsOpen = true; //Flag for testing to check if closeAuction is reached

     function Auction(address nftowner, address _nft, uint _nftId, uint maxbids, uint256 buyNow) public{
        nft = IERC721(_nft);
        nftId = _nftId;
       // auctionClose = block.timestamp + biddingTime;
        testnum = 0;
        nftOwner= nftowner;
        maxBids = maxbids;
        buyNowPrice = buyNow;
    }
 
     
    //checks if bid is at the buyNowPrice, if so, ends auction
    //Otherwise, adds to map of addresses + allBids
    //Calls updateTopdBid 
    //if bid is reaches the max, endAuction
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
    
    // currently working
    //Checks if bidAmount is greater than the current topBid,
    //if true, updates given paramters as teh new topdBid and TopBidder
    function updateTopBid(uint bidAmount,address bidder) public{
        if(bidAmount >topBid){
            topBid = bidAmount;
            topBidder = bidder;
        }
        
        
    }
    
    //Ends Auction, calls transferNFT
    function closeAuction() public{
        auctionIsOpen = false;
        transferNFT(nftOwner);
    }
    
    
//Setup Note: -run  remixd -s . --remix-ide https://remix.ethereum.org/ in github directory before connecting to localhost
//Runtime notes: -deploy thingy - create nft with the contract address as the owner -use constructor on contract, put my address as beneficiaryAddress -transferNFT with contract address as owner
    
    //current source of error: transferring nft that is not owned
    function transferNFT(address owner) public payable{
      
        nft.safeTransferFrom(owner,topBidder,nftId);

    }
    
}