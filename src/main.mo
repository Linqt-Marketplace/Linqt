import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";

actor EscrowService {

  // Define escrow data structure
  type EscrowInfo = {
    id: Text;
    description: Text;
    amount: Nat;
    creator: Principal;
    createdAt: Int;
    status: Text; // "active", "completed", "cancelled"
  };

  // Store escrows by ID
  private stable var escrowEntries : [(Text, EscrowInfo)] = [];
  private var escrows = HashMap.fromIter<Text, EscrowInfo>(
    escrowEntries.vals(), escrowEntries.size(), Text.equal, Text.hash
  );

  // Counter for generating unique IDs
  private stable var nextId : Nat = 1;

  // Generate a simple ID
  private func generateId() : Text {
    let id = "escrow_" # Nat.toText(nextId);
    nextId += 1;
    id
  };

  // Create a new escrow
  public shared(msg) func createEscrow(description: Text, amount: Nat) : async Text {
    let id = generateId();
    let escrow : EscrowInfo = {
      id = id;
      description = description;
      amount = amount;
      creator = msg.caller;
      createdAt = Time.now();
      status = "active";
    };
    
    escrows.put(id, escrow);
    id
  };

  // Get escrow information by ID
  public query func getEscrowInfo(id: Text) : async ?EscrowInfo {
    escrows.get(id)
  };

  // Get all escrows (for demo purposes)
  public query func getAllEscrows() : async [EscrowInfo] {
    Iter.toArray(escrows.vals())
  };

  // System functions for upgrades
  system func preupgrade() {
    escrowEntries := Iter.toArray(escrows.entries());
  };

  system func postupgrade() {
    escrowEntries := [];
  };
}