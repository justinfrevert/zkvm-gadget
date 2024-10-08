## ZKVM Example Blueprint

A simple blueprint that computes a result in a ZKVM and sends a proof to be verified by its own contract. Upon noting a job event, the gadget will respond by generating an arbitrary proof, compressing it for verification within the EVM, and then respond to the event by sending the proof to the contract verifier.

## RISC Zero

- RISC Zero is a ZKVM which can generate proofs which can be verified in the EVM. See [more](https://github.com/risc0/risc0). The core logic which invokes the ZKVM guest and runs the custom logic inside is in `./methods`.

## Building the Blueprint

- To build the blueprint, just run the following command:

```bash
cargo build -p zkvm-blueprint
```

- and to build the gadget that uses the blueprint, run the following command:

```bash
cargo build -p zkvm-blueprint --features=gadget
```

## Running the Gadget

- To run the gadget on Local Tangle Network, make sure you have tangle running on your local machine first by running the following command:

```bash
bash ./scripts/run-standalone-local.sh --clean
```

- Add Alice to your local keystore, so that the gadget can use it to sign transactions:

```bash
 echo -n "e5be9a5092b81bca64be81d212e7f2f9eba183bb7a90954f7b76361f6edb5c0a" > target/keystore/0000d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d
```

- Then, use the following command to run the gadget that uses the blueprint:

```bash
RPC_URL=ws://localhost:9944 KEYSTORE_URI=file://./target/keystore BLUEPRINT_ID=0 SERVICE_ID=0 RUST_LOG=zkvm_gadget,gadget_sdk=trace,error cargo r -p zkvm-blueprint --features=gadget
```

That's it! You should see the gadget running and listening for incoming requests on the Local Tangle Network.

## Deploying the Blueprint to the Tangle

- To deploy the blueprint to the tangle, make sure you have tangle running on your local machine first by running the following command:

```bash
bash ./scripts/run-standalone-local.sh --clean
```

- (Optionally) Visit [Polkadot JS UI](https://polkadot.js.org/apps/?rpc=ws://127.0.0.1:9944#/explorer) to check the status of the tangle network.
- Install the required dependencies by running the following command:

```bash
cd blueprints/zkvm && yarn install
```

- Compile the Contracts using forge command:

```bash
forge build --root ./contracts
```

- Next, run the following command to deploy the blueprint to the tangle:

```bash
yarn tsx deploy.ts
```

This script will deploy the blueprint to the tangle network, and create a service instance that you can use to interact with the blueprint, then submit a request to the service instance to square a number.
