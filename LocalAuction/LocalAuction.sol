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

     function Auction(address payable beneficiary, address nftowner, address _nft, uint _nftId, uint maxbids) public{
        beneficiaryAddress = beneficiary;
        nft = IERC721(_nft);
        nftId = _nftId;
       // auctionClose = block.timestamp + biddingTime;
        testnum = 0;
        nftOwner= nftOwner;
        maxBids = maxbids;
    }
 
     
    //lets user bid an amount, if amount of bids is greater than 
     function bid(uint bidAmount, address bidder) public{
        updateTopBid(bidAmount,bidder);
        allBids[bidder] = bidAmount;
        amountOfBids++;
        if(amountOfBids == maxBids){
          closeAuction();
        }
    }
    
    function updateTopBid(uint bidAmount,address bidder){
        if(bidAmount >topBid){
            topBidder = bidder;
        }
        
    }
    function closeAuction() public{
        require(block.timestamp >= auctionClose);
        transferNFT();
    }
    
    
//Setup Note: -run  remixd -s . --remix-ide https://remix.ethereum.org/ in github directory before connecting to localhost
//Runtime notes: -deploy thingy - create nft with the contract address as the owner -use constructor on contract, put my address as beneficiaryAddress -transferNFT with contract address as owner
    
    function transferNFT() public payable{
        //Okay this is now working yay
        nft.safeTransferFrom(nftOwner,beneficiaryAddress,nftId);

    }
    
}