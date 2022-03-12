

//Day 6 Challenges
/// This is a documentation comment it is attached  the definitiion immediatey following

import Result "mo:base/Result";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";
import Hash "mo:base/Hash";
import Array "mo:base/Array";

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

private stable var registryEntries : [(TokenIndex, Principal)] = [];
private stable var tokendata : [(TokenIndex, Text)] = [];
private stable var balancesEntries : [(Principal, Nat)] = [];


private let registry : HashMap.HashMap<TokenIndex, Principal> = HashMap.fromIter<TokenIindex, Principal>(registryEntries.vals(), 10, Nat.equal, Hash.hash);

private let tokenURIs : HashMap.HashMap<TokenIndex, Text> = HashMap.fromIter<TokenIndex, Text>(tokendataEntries.vals(), 10, Nat.equal, Hash.hash);

private let balances : HashMap.HashMap<Principal, Nat> = HashMap.fromIter<Principal, Nat>(balancesEntries.vals(), 10, Principal.equal, Principal.hash);

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

  // public shared({caller}) func mint() : async MintResult{
    
  //   switch(Principal.isAnonymous(caller)){
  //     case(true){
  //       #err("Calling canister identifies as anonymous. This service requires authentication.");
  //       };
  //     case(false) //caller is not anonymous, mint token to caller and Increment Token Index
  //      { 
  //       Debug.print("Minting Token ID: " # Nat.toText(nextTokenIndex) # " for: " # Principal.toText(caller));
  //       registry.put(nextTokenIndex, caller);
  //       nextTokenIndex := nextTokenIndex +1;
  //       #ok;
  //      };
  //   };
  // };

//Challenge 4 - transfer function
//transfer ownership of tokenIndex to the specified principal.
//check for errors and return type **Result**.
//public func transfer(to : Principal, tokenIndex : Nat) : async {

  public shared(msg) func transferFrom(from : Principal, to : Principal, tokenId : Nat) : () {
        assert _isApprovedOrOwner(msg.caller, tokenId);

        _transfer(from, to, tokenId);
    };

  private func _transfer(from : Principal, to : Principal, tokenId : Nat) : () {
        assert _exists(tokenId);
        _incrementBalance(to);
        owners.put(tokenId, to);
    };

  private func _exists(tokenId : Nat) : Bool {
        return Option.isSome(owners.get(tokenId));
    };

  private func _incrementBalance(address : Principal) {
        switch (balances.get(address)) {
            case (?v) {
                balances.put(address, v + 1);
            };
            case null {
                balances.put(address, 1);
            }
        }
    };


// public shared({caller}) func transfer(newowner : Principal, token : TokenIndex) : async TransferResult{
    
//     switch(Principal.isAnonymous(caller)){
//       case(true){
//         #err("Calling canister identifies as anonymous. This service requires authentication.");
//         };
//       case(false) //caller is not anonymous, transfer token to new owner.
//        { 
//         //Get owner of tokenID, if same as caller do transfer, else err 
//         var currentowner: ?Principal = registry.get(token);
//         if(caller != currentowner)
//           {
//           Debug.print("Transferring Token ID: " # Nat.toText(token) # "to: " # Principal.toText(newowner));
//           registry.put(token, newowner); 
//           #ok;
//           } else {
//           #err("you must own the token to transfer it.");
//           };
//         };
//       };
    
//   };




// var registry : HashMap.HashMap<TokenIndex, Principal> = HashMap.HashMap(10, Nat.equal, Hash.hash);
// Challenge 5 : balance function returns a list of tokenIndex owned by the called.
// registry.get(token);



// public shared({caller}) func balance(owner_query : Principal) : async TransferResult{
// switch(Principal.isAnonymous(caller)){
//       case(true){
//         #err("Calling canister identifies as anonymous. This service requires authentication.");
//         };
//       case(false) //caller is not anonymous, transfer token to new owner.
//        { 
//         // iterate through getting tokens of the owner_query
//         Debug.print("Starting count Tokens - for: " # Principal.toText(owner_query));
//         for(t in registry.vals(owner_query){
//           Debug.print(Principal.toText(owner_query) # "owns token:" # Nat.toText(t));
//           };
//         #ok;  
//         };
//       };
//     };



//Challenge 6 : http_request function returns latest minters stock.
//public func http_request() Text{
//return number minted by latest minter
//};


//Challenge 7 : Modify the actor for safe upgrade without loosing state.
//Therefore  declared the registry HashMap as stable.
//and added system preupgrade and post upgrade routines

    system func preupgrade() {
        registryEntries := Iter.toArray(registry.entries());
        tokendataEntries := Iter.toArray(tokendata.entries());
        balancesEntries := Iter.toArray(balances.entries());
    };

    system func postupgrade() {
        registryEntries := [];
        tokendataEntries := [];
        balancesEntries := [];
    };
};

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

//Studying:https://github.com/motoko-bootcamp/bootcamp/blob/main/core_project/example/src/minter/main.mo
//
// private stable var tokenURIEntries : [(T.TokenId, Text)] = [];
//     private stable var ownersEntries : [(T.TokenId, Principal)] = [];
//     private stable var balancesEntries : [(Principal, Nat)] = [];
//     private stable var tokenApprovalsEntries : [(T.TokenId, Principal)] = [];
//     private stable var operatorApprovalsEntries : [(Principal, [Principal])] = [];  

//     private let tokenURIs : HashMap.HashMap<T.TokenId, Text> = HashMap.fromIter<T.TokenId, Text>(tokenURIEntries.vals(), 10, Nat.equal, Hash.hash);
//     private let owners : HashMap.HashMap<T.TokenId, Principal> = HashMap.fromIter<T.TokenId, Principal>(ownersEntries.vals(), 10, Nat.equal, Hash.hash);
//     private let balances : HashMap.HashMap<Principal, Nat> = HashMap.fromIter<Principal, Nat>(balancesEntries.vals(), 10, Principal.equal, Principal.hash);
//     private let tokenApprovals : HashMap.HashMap<T.TokenId, Principal> = HashMap.fromIter<T.TokenId, Principal>(tokenApprovalsEntries.vals(), 10, Nat.equal, Hash.hash);
//     private let operatorApprovals : HashMap.HashMap<Principal, [Principal]> = HashMap.fromIter<Principal, [Principal]>(operatorApprovalsEntries.vals(), 10, Principal.equal, Principal.hash);


 // Mint requires authentication in the frontend as we are using caller.
    //  public shared ({caller}) func mint(uri : Text) : async Nat {
    //     tokenPk += 1;
    //     _mint(caller, tokenPk, uri);
    //     return tokenPk;
    // };


    // // Internal

    // private func _ownerOf(tokenId : T.TokenId) : ?Principal {
    //     return owners.get(tokenId);
    // };
//  private func _mint(to : Principal, tokenId : Nat, uri : Text) : () {
//         assert not _exists(tokenId);

//         _incrementBalance(to);
//         owners.put(tokenId, to);
//         tokenURIs.put(tokenId,uri)
//     };