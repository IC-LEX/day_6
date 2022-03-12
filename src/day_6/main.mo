

//Day 6 Challenges
/// This is a documentation comment it is attached  the definitiion immediatey following

import Result "mo:base/Result"
import Text "mo:base/Text"
import Nat "mo:base/Nat"
import HashMap "mo:base/HashMap"

actor {
  // Challenge 1
  type TokenIndex = Nat;
  type Error = {
    #error;
    #other_error;
  };

// Challenge 2
//Declare registry HashMap called  Key TokenIndex, value Principal. which principal owns which TokenIndex.
  let registry : HashMap.HashMap<TokenIndex, Principal> = (0, Principal.equal, Principal.hash);

// Challenge 3 - Nat called nextTokenIndex, indexing number of minted NFTs.
  var nextTokenIndex : Nat = 0;  //Number of minted NFTs

//Mint function - If the user is authenticated,
// associate the current TokenIndex with the caller
// and increase nextTokenIndex
// indicate an error in case the caller is anonymous.

  type MintResult<(), Text> = Result{#ok; #err : Text};
 
  public shared({caller}) func mint(p caller: Principal) : async MintResult{
    if Principal.isAnonymous(caller)){
      return #err("Calling canister identifies as anonymous. This service requires authentication.");}
    else{
    //caller is known, mint token to caller and Increment Token Index
      registry.put(TokenIndex, caller);
      += TokenIndex;
      return #ok
    };
  };

//Challenge 4 - transfer function
//transfer ownership of tokenIndex to the specified principal.
// check for errors and return type **Result**.
public func transfer(to : Principal, tokenIndex : Nat) : async {


};

// Challenge 5 : balance function returns a list of tokenIndex owned by the called.

public func balance(){

};

//Challenge 6 : http_request function returns latest minters stock.
public func http_request() Text{
//return number minted by latest minter
};

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

};