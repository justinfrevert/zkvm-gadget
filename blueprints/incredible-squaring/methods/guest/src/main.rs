use alloy_primitives::U256;
use alloy_sol_types::{sol, SolValue};
use risc0_zkvm::guest::env;

sol! {
    struct Journal {
        uint256 result;
    }
}

// Simply square the input inside of the guest and commit to the abi encoding of its result
fn main() {
    let input: u32 = env::read();
    // This program simply squares the guest's input
    let num = U256::from(input.pow(2));
    let journal = Journal { result: num };
    // Commit to abi encoding of the result
    env::commit_slice(&journal.abi_encode());
}
