

//Day 6 Challenges
/// This is a documentation comment it is attached  the definitiion immediatey following

import Result "mo:base/Result";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";
import Hash "mo:base/Hash";

actor {
  // Challenge 1
  public type TokenIndex = Nat;
  type Error = {
    #error;
    #other_error;
  };

// Challenge 3 - Nat called nextTokenIndex, indexing number of minted NFTs.
var nextTokenIndex : Nat = 0;  //Number of minted NFTs

// Challenge 2
//Declare registry HashMap called  Key TokenIndex, value Principal. which principal owns which TokenIndex.
//Changed this around from Challenge 3 (commented it out for now) - try index into HashMap by TokenIndex.
 var registry : HashMap.HashMap<TokenIndex, Principal> = HashMap.HashMap(10, Nat.equal, Hash.hash);

//Mint function - If the user is authenticated,
// associate the current TokenIndex with the caller
// and increase nextTokenIndex
// indicate an error in case the caller is anonymous.
  public type Result<T, E> = {
    #ok : T;
    #err : E;
  };


  //(?) build out different Result types...
  public type MintResult = Result<(), Text>;
  public type TransferResult = Result<(), Text>;

  public shared({caller}) func mint() : async MintResult{
    
    switch(Principal.isAnonymous(caller)){
      case(true){
        #err("Calling canister identifies as anonymous. This service requires authentication.");
        };
      case(false) //caller is not anonymous, mint token to caller and Increment Token Index
       { 
        Debug.print("Minting Token ID: " # Nat.toText(nextTokenIndex));
        registry.put(nextTokenIndex, caller);
        nextTokenIndex := nextTokenIndex +1;
        #ok;
       };
    };
  };

//Challenge 4 - transfer function
//transfer ownership of tokenIndex to the specified principal.
//check for errors and return type **Result**.
//public func transfer(to : Principal, tokenIndex : Nat) : async {

public shared({caller}) func transfer(newowner : Principal, token : TokenIndex) : async TransferResult{
    
    switch(Principal.isAnonymous(caller)){
      case(true){
        #err("Calling canister identifies as anonymous. This service requires authentication.");
        };
      case(false) //caller is not anonymous, transfer token to new owner.
       { 
        //Get owner of tokenID, if same as caller do transfer, else err 
        var currentowner: ?Principal = registry.get(token);
        if(caller != currentowner)
          {
          Debug.print("Transferring Token ID: " # Nat.toText(token) # "to: " # Principal.toText(newowner));
          registry.put(token, newowner); 
          #ok;
          } else {
          #err("you must own the token to transfer it.");
          };
        };
      };
    
  };


};  // This is the actor definition termination


// Challenge 5 : balance function returns a list of tokenIndex owned by the called.

//public func balance(){

//}

//Challenge 6 : http_request function returns latest minters stock.
//public func http_request() Text{
//return number minted by latest minter
//};

//Challenge 7 : Modify the actor for safe upgrade without loosing state.
//Therefore  declared the registry HashMap as stable.
//and added system preupgrade and post upgrade routines


//🔥🔥🔥 Call NIST. We have a new Token standard. 🔥🔥🔥.





//🔥Bonus Challenges 8, 9, 10: intercanister calls🔥

//Challenge 8
//Create another canister that mints an NFT by calling
//the mint method of your first canister.



//🔒🔒🔒just created our own on-chain wallet. 🔒🔒🔒.


//Challenge 9 - default_account function for Ledger canister 💰 actor / canister
//returns the address of the subbacount 0 for the canister.


//Challenge 10
// - balance function returns icp in canister's default account.
// - transfer function, see lectures on the ledger canister.
// - Example of icp in canister: