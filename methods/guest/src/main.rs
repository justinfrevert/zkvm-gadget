use alloy_primitives::U256;
use alloy_sol_types::{sol, SolValue};
use risc0_zkvm::guest::env;

sol! {
    struct Journal {
        uint256 result;
    }
}

fn main() {
    let input: u32 = env::read();

    let num = U256::from(input.pow(2));

    let journal = Journal { result: num };
    env::commit_slice(&journal.abi_encode());
}
