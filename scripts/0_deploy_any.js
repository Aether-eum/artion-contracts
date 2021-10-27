async function main() {
    const [deployer] = await ethers.getSigners();
    const deployerAddress = await deployer.getAddress();
    console.log('Deploying contract with address:', deployerAddress);

    const contractObj = await ethers.getContractFactory('POS');
    const contract = await contractObj.deploy();

    await contract.deployed();

    console.log('Contract deployed at', contract.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
